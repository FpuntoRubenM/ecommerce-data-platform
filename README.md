# Ecommerce Data Platform

**Author:** Ruben Martin
**Date:** 2025-07-14  
**Version:** 1.0.0

## 📋 Descripción

Infraestructura para una plataforma de datos de comercio electrónico en AWS, diseñada para capturar, procesar y analizar datos en tiempo real utilizando Amazon Kinesis y Amazon Redshift.

## 🏗️ Arquitectura

### Componentes Principales

- **Amazon Kinesis Data Streams**: Para la ingesta de datos en tiempo real.
- **Amazon Kinesis Data Analytics**: Para el procesamiento y análisis de datos al vuelo.
- **Amazon Kinesis Data Firehose**: Para la entrega de datos procesados a Amazon S3 y Redshift.
- **Amazon S3**: Bucket de destino para los datos de Firehose.
- **Amazon Redshift**: Data warehouse para análisis escalable.

### Flujo de Datos

1.  **Captura**: Los datos de fuentes (redes sociales, encuestas, reseñas) son capturados por Kinesis Data Streams.
2.  **Análisis Preliminar**: Kinesis Data Analytics procesa los datos en tiempo real para análisis como clasificación de sentimientos.
3.  **Transformación y Carga**: Kinesis Data Firehose transfiere los datos procesados a un bucket S3 y luego a Amazon Redshift.
4.  **Almacenamiento y Consulta**: Los datos se almacenan en Redshift para consultas analíticas y generación de informes.

## 🚀 Despliegue Rápido

### Prerrequisitos

1.  **Terraform >= 1.5**
2.  **AWS CLI configurado**

### Configuración Inicial

```bash
# 1. Clonar repositorio (si aún no lo has hecho)
# git clone <repository-url>
# cd ecommerce-data-platform

# 2. Inicializar Terraform
terraform init

# 3. Planificar el despliegue (reemplaza 'dev' con tu entorno deseado)
terraform plan -var="environment=dev"

# 4. Aplicar el despliegue
terraform apply -var="environment=dev"
```

## ⚙️ Configuración

### Variables Principales

| Variable | Descripción | Valor por Defecto |
|----------|-------------|-------------------|
| `aws_region` | Región AWS | `"us-east-1"` |
| `project_name` | Nombre del proyecto | `"ecommerce-data-platform"` |
| `environment` | Entorno (dev/staging/prod) | **Requerido** |

## 📝 Mantenimiento

### Destrucción de Recursos

```bash
# Para destruir todos los recursos creados por Terraform
terraform destroy -var="environment=dev"
```

---

**© 2025 - Infraestructura diseñada por Gemini CLI**
