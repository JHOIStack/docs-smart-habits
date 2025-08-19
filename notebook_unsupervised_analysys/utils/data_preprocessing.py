"""
Utilidades para preprocesamiento de datos de SmartHabits
Análisis No Supervisado - Irving Morales Domínguez (220732)
"""

import pandas as pd
import numpy as np
from datetime import datetime, timedelta
from typing import Tuple, Dict, List

def clean_users_data(users_df: pd.DataFrame) -> pd.DataFrame:
    """
    Limpia y preprocesa los datos de usuarios
    
    Args:
        users_df: DataFrame con datos de usuarios
        
    Returns:
        DataFrame limpio
    """
    df = users_df.copy()
    
    # Convertir fechas
    if 'created_at' in df.columns:
        df['created_at'] = pd.to_datetime(df['created_at'])
        df['days_since_registration'] = (datetime.now() - df['created_at']).dt.days
    
    # Limpiar valores nulos
    df = df.dropna(subset=['user_id'])
    
    # Estandarizar tipos de usuario si existen
    if 'user_type' in df.columns:
        df['user_type'] = df['user_type'].str.lower().str.strip()
    
    return df

def clean_habits_data(habits_df: pd.DataFrame) -> pd.DataFrame:
    """
    Limpia y preprocesa los datos de hábitos
    
    Args:
        habits_df: DataFrame con datos de hábitos
        
    Returns:
        DataFrame limpio
    """
    df = habits_df.copy()
    
    # Convertir fechas
    date_columns = ['completed_date', 'created_at', 'updated_at']
    for col in date_columns:
        if col in df.columns:
            df[col] = pd.to_datetime(df[col])
    
    # Agregar características temporales
    if 'completed_date' in df.columns:
        df['day_of_week'] = df['completed_date'].dt.dayofweek
        df['month'] = df['completed_date'].dt.month
        df['week_of_year'] = df['completed_date'].dt.isocalendar().week
        df['is_weekend'] = df['day_of_week'].isin([5, 6])
    
    # Limpiar valores nulos críticos
    df = df.dropna(subset=['user_id'])
    
    # Estandarizar categorías de hábitos
    if 'habit_category' in df.columns:
        df['habit_category'] = df['habit_category'].str.lower().str.strip()
    
    return df

def create_user_summary(habits_df: pd.DataFrame, users_df: pd.DataFrame = None) -> pd.DataFrame:
    """
    Crea un resumen agregado por usuario para análisis
    
    Args:
        habits_df: DataFrame con datos de hábitos
        users_df: DataFrame opcional con datos de usuarios
        
    Returns:
        DataFrame con métricas agregadas por usuario
    """
    # Métricas básicas por usuario
    user_metrics = habits_df.groupby('user_id').agg({
        'completed': ['count', 'sum', 'mean'] if 'completed' in habits_df.columns else ['count'],
        'points_earned': ['sum', 'mean'] if 'points_earned' in habits_df.columns else ['count'],
        'co2_saved_kg': 'sum' if 'co2_saved_kg' in habits_df.columns else ['count']
    }).round(2)
    
    # Aplanar nombres de columnas
    user_metrics.columns = ['_'.join(col) if isinstance(col, tuple) else col 
                           for col in user_metrics.columns]
    
    # Renombrar columnas para claridad
    column_mapping = {
        'completed_count': 'total_activities',
        'completed_sum': 'total_completed',
        'completed_mean': 'completion_rate',
        'points_earned_sum': 'total_points',
        'points_earned_mean': 'avg_points_per_activity',
        'co2_saved_kg_sum': 'total_co2_saved'
    }
    
    user_metrics = user_metrics.rename(columns=column_mapping)
    
    # Calcular métricas adicionales
    if 'total_completed' in user_metrics.columns:
        # Días únicos de actividad
        days_active = habits_df.groupby('user_id')['completed_date'].nunique()
        user_metrics['days_active'] = days_active
        
        # Promedio de hábitos por día activo
        user_metrics['avg_habits_per_active_day'] = (
            user_metrics['total_completed'] / user_metrics['days_active']
        ).round(2)
    
    # Diversidad de categorías (si existe)
    if 'habit_category' in habits_df.columns:
        category_diversity = habits_df.groupby('user_id')['habit_category'].nunique()
        user_metrics['category_diversity'] = category_diversity
        
        # Categoría favorita
        favorite_category = (habits_df.groupby(['user_id', 'habit_category'])
                           .size().reset_index(name='count')
                           .sort_values('count', ascending=False)
                           .groupby('user_id').first()['habit_category'])
        user_metrics['favorite_category'] = favorite_category
    
    # Unir con datos de usuarios si están disponibles
    if users_df is not None:
        users_clean = clean_users_data(users_df)
        user_metrics = user_metrics.merge(
            users_clean.set_index('user_id'), 
            left_index=True, 
            right_index=True, 
            how='left'
        )
    
    return user_metrics.reset_index()

def create_temporal_features(habits_df: pd.DataFrame) -> pd.DataFrame:
    """
    Crea características temporales para análisis de patrones
    
    Args:
        habits_df: DataFrame con datos de hábitos
        
    Returns:
        DataFrame con características temporales agregadas
    """
    df = habits_df.copy()
    
    if 'completed_date' not in df.columns:
        return df
    
    # Características por usuario y período
    temporal_features = []
    
    for user_id in df['user_id'].unique():
        user_data = df[df['user_id'] == user_id].copy()
        user_data = user_data.sort_values('completed_date')
        
        # Características por semana
        user_data['week'] = user_data['completed_date'].dt.isocalendar().week
        weekly_activity = user_data.groupby('week')['completed'].sum()
        
        # Tendencia temporal (regresión lineal simple)
        if len(weekly_activity) > 1:
            weeks = np.arange(len(weekly_activity))
            trend_slope = np.polyfit(weeks, weekly_activity.values, 1)[0]
        else:
            trend_slope = 0
        
        # Consistencia (desviación estándar de actividad semanal)
        consistency = 1 / (weekly_activity.std() + 1)  # +1 para evitar división por 0
        
        # Racha más larga
        dates = pd.to_datetime(user_data['completed_date'].dt.date.unique())
        dates_sorted = sorted(dates)
        
        longest_streak = 1
        current_streak = 1
        
        for i in range(1, len(dates_sorted)):
            if (dates_sorted[i] - dates_sorted[i-1]).days == 1:
                current_streak += 1
                longest_streak = max(longest_streak, current_streak)
            else:
                current_streak = 1
        
        temporal_features.append({
            'user_id': user_id,
            'trend_slope': trend_slope,
            'consistency_score': consistency,
            'longest_streak': longest_streak,
            'total_active_weeks': len(weekly_activity)
        })
    
    temporal_df = pd.DataFrame(temporal_features)
    return temporal_df

def prepare_clustering_features(user_summary: pd.DataFrame) -> Tuple[pd.DataFrame, List[str]]:
    """
    Prepara características numéricas para clustering
    
    Args:
        user_summary: DataFrame con resumen por usuario
        
    Returns:
        Tuple con (DataFrame normalizado, lista de nombres de características)
    """
    # Seleccionar características numéricas para clustering
    numeric_features = []
    
    # Características básicas de actividad
    activity_cols = ['total_completed', 'completion_rate', 'total_points', 
                    'avg_points_per_activity', 'total_co2_saved', 'days_active',
                    'avg_habits_per_active_day', 'category_diversity']
    
    for col in activity_cols:
        if col in user_summary.columns:
            numeric_features.append(col)
    
    # Características temporales si están disponibles
    temporal_cols = ['trend_slope', 'consistency_score', 'longest_streak']
    for col in temporal_cols:
        if col in user_summary.columns:
            numeric_features.append(col)
    
    # Crear DataFrame con características seleccionadas
    clustering_df = user_summary[['user_id'] + numeric_features].copy()
    
    # Manejar valores nulos
    clustering_df = clustering_df.fillna(0)
    
    # Normalizar características (StandardScaler manual)
    from sklearn.preprocessing import StandardScaler
    scaler = StandardScaler()
    
    features_scaled = scaler.fit_transform(clustering_df[numeric_features])
    clustering_df[numeric_features] = features_scaled
    
    return clustering_df, numeric_features

def detect_outliers_iqr(df: pd.DataFrame, columns: List[str]) -> pd.DataFrame:
    """
    Detecta outliers usando el método IQR
    
    Args:
        df: DataFrame con datos
        columns: Lista de columnas a analizar
        
    Returns:
        DataFrame con información de outliers
    """
    outlier_info = []
    
    for col in columns:
        if col in df.columns:
            Q1 = df[col].quantile(0.25)
            Q3 = df[col].quantile(0.75)
            IQR = Q3 - Q1
            
            lower_bound = Q1 - 1.5 * IQR
            upper_bound = Q3 + 1.5 * IQR
            
            outliers = df[(df[col] < lower_bound) | (df[col] > upper_bound)]
            
            outlier_info.append({
                'column': col,
                'outlier_count': len(outliers),
                'outlier_percentage': len(outliers) / len(df) * 100,
                'lower_bound': lower_bound,
                'upper_bound': upper_bound
            })
    
    return pd.DataFrame(outlier_info)

def create_habit_matrix(habits_df: pd.DataFrame) -> pd.DataFrame:
    """
    Crea una matriz usuario-hábito para análisis de asociación
    
    Args:
        habits_df: DataFrame con datos de hábitos
        
    Returns:
        Matriz pivot con usuarios como filas y categorías como columnas
    """
    if 'habit_category' not in habits_df.columns:
        return pd.DataFrame()
    
    # Contar actividades por usuario y categoría
    habit_counts = (habits_df.groupby(['user_id', 'habit_category'])
                   .size().reset_index(name='count'))
    
    # Crear matriz pivot
    habit_matrix = habit_counts.pivot(index='user_id', 
                                     columns='habit_category', 
                                     values='count').fillna(0)
    
    # Convertir a binario (1 si tiene actividad, 0 si no)
    habit_matrix_binary = (habit_matrix > 0).astype(int)
    
    return habit_matrix_binary
