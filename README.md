# Notebooks Explorer App Project

## Descripción
Este proyecto es una aplicación de exploración de productos de notebooks desarrollada en Flutter.

## Tecnologías Utilizadas
- **Lenguaje de Programación**: Dart
- **Framework**: Flutter
- **Gestión de Estado**: Flutter Bloc
- **APIs**: MercadoLibre API

## Dependencias
El proyecto utiliza varias dependencias de Flutter y Dart, incluyendo:
- `http`: Para realizar peticiones HTTP a la API de MercadoLibre.
- `flutter_bloc`: Para la gestión de estado mediante el patrón Bloc.
- `shared_preferences`: Para almacenar datos localmente en la aplicación.

## Objetivos Cumplidos
Los siguientes objetivos propuestos fueron cumplidos durante el desarrollo del proyecto:

- **Buscar una lista de productos que coincidan con un criterio de búsqueda**
- **Mostrar los resultados en una lista con título, precio y miniatura**
- **Inspeccionar un elemento particular en una vista detallada**
- **Almacenar una referencia a los últimos 5 elementos visitados en una vista detallada**

Estos objetivos permiten a los usuarios buscar productos, ver detalles de los productos encontrados y acceder fácilmente a los productos recientemente visitados.
A continuación se muestran las imagenes descriptivas de la app:

![mobile-app-notebooks](https://github.com/pablex72/flutter-notebook-explorer-app/assets/118881130/eba6f04d-b0fa-4342-ac2e-f592e118dfb4)

## Data storage: persistent - `shared_preferences`
En la aplicación se utiliza `shared_preferences` para guardar los productos seleccionados por el usuario en la pantalla de detalle, permitiendo así que el usuario pueda acceder a ellos posteriormente.

## Detalles de Implementación
La aplicación carga una lista de productos de notebooks desde la API de MercadoLibre (https://api.mercadolibre.com/sites/MLU/search?q=notebook#json) y permite al usuario buscar entre ellos. Además, el usuario puede seleccionar productos como favoritos, los cuales se guardan localmente utilizando `shared_preferences`.

## Información Adicional
- **Nombre del Proyecto**: flutter_application_notebooks
- **Versión**: 1.0.0+1
- **Entorno SDK**: >=3.4.0 <4.0.0
