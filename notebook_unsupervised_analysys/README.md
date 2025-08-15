# 🔍 Análisis No Supervisado - SmartHabits

## 📊 Objetivo
Aplicar técnicas de machine learning no supervisado para descubrir patrones ocultos en los datos de hábitos sostenibles de los usuarios de SmartHabits, con el fin de mejorar la personalización y efectividad del sistema.

## 🎯 Casos de Uso Específicos

### 1. **Segmentación de Usuarios (Clustering)**
- **Objetivo**: Identificar diferentes tipos de usuarios según sus patrones de hábitos sostenibles
- **Algoritmos**: K-Means, DBSCAN, Hierarchical Clustering
- **Variables**: Frecuencia de hábitos, categorías preferidas, puntuación obtenida, tiempo de uso
- **Resultado**: Perfiles como "Eco-Principiante", "Eco-Experto", "Especialista en Reciclaje", etc.

### 2. **Detección de Anomalías**
- **Objetivo**: Identificar comportamientos inusuales o usuarios en riesgo de abandono
- **Algoritmos**: Isolation Forest, One-Class SVM, Local Outlier Factor
- **Variables**: Cambios súbitos en actividad, patrones de uso irregulares
- **Resultado**: Sistema de alertas tempranas para retención de usuarios

### 3. **Análisis de Asociación de Hábitos**
- **Objetivo**: Descubrir qué hábitos sostenibles tienden a realizarse juntos
- **Algoritmos**: Apriori, FP-Growth
- **Variables**: Combinaciones de hábitos por usuario y período
- **Resultado**: Recomendaciones inteligentes de nuevos hábitos

### 4. **Reducción Dimensional y Visualización**
- **Objetivo**: Visualizar patrones complejos en espacios de menor dimensión
- **Algoritmos**: PCA, t-SNE, UMAP
- **Variables**: Todas las métricas de hábitos y gamificación
- **Resultado**: Dashboards interactivos para insights de negocio

### 5. **Análisis Temporal de Patrones**
- **Objetivo**: Identificar patrones estacionales y temporales en hábitos sostenibles
- **Algoritmos**: Clustering temporal, DTW (Dynamic Time Warping)
- **Variables**: Series de tiempo de actividad por hábito
- **Resultado**: Optimización de recordatorios y campañas

## 📁 Estructura de Notebooks

```
notebook_unsupervised_analysys/
├── 01_exploratory_data_analysis.ipynb     # EDA inicial de datos SmartHabits
├── 02_user_clustering.ipynb               # Segmentación de usuarios
├── 03_anomaly_detection.ipynb             # Detección de comportamientos atípicos
├── 04_habit_association_rules.ipynb       # Reglas de asociación entre hábitos
├── 05_dimensionality_reduction.ipynb      # PCA, t-SNE para visualización
├── 06_temporal_pattern_analysis.ipynb     # Análisis de patrones temporales
├── 07_recommendation_system.ipynb         # Sistema de recomendaciones no supervisado
├── utils/                                 # Funciones auxiliares
│   ├── data_preprocessing.py
│   ├── clustering_utils.py
│   └── visualization_helpers.py
└── data/                                  # Datos simulados/anonimizados
    ├── user_habits_sample.csv
    ├── gamification_data.csv
    └── environmental_impact_data.csv
```

## 🛠️ Tecnologías y Librerías

- **Python**: Jupyter Notebooks
- **Análisis**: pandas, numpy, scipy
- **ML**: scikit-learn, mlxtend (para reglas de asociación)
- **Visualización**: matplotlib, seaborn, plotly
- **Clustering avanzado**: hdbscan, umap-learn
- **Series temporales**: tslearn, dtaidistance

## 📈 Métricas y Evaluación

### Clustering
- Silhouette Score
- Calinski-Harabasz Index  
- Davies-Bouldin Index
- Interpretabilidad de clusters

### Detección de Anomalías
- Precision, Recall, F1-Score
- Tasa de falsos positivos
- Validación manual de anomalías detectadas

### Reglas de Asociación
- Support, Confidence, Lift
- Interpretabilidad y aplicabilidad práctica

## 🎯 Impacto Esperado

1. **Personalización mejorada**: Recomendaciones más precisas basadas en clusters de usuarios
2. **Retención de usuarios**: Detección temprana de usuarios en riesgo
3. **Optimización de gamificación**: Ajustar recompensas según perfiles de usuario
4. **Insights de producto**: Entender mejor cómo los usuarios adoptan hábitos sostenibles
5. **Campañas dirigidas**: Segmentación para marketing y comunicación efectiva

## 🔄 Pipeline de Análisis

1. **Extracción de datos** → ETL desde base de datos SmartHabits
2. **Preprocesamiento** → Limpieza, normalización, feature engineering
3. **Análisis exploratorio** → Comprensión inicial de patrones
4. **Modelado no supervisado** → Aplicación de algoritmos
5. **Validación e interpretación** → Evaluación de resultados
6. **Implementación** → Integración con sistema de recomendaciones

---

*Desarrollado por Irving Morales Domínguez (220732) para el proyecto SmartHabits/SmartEcoWatch*
