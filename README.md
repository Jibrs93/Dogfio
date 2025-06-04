# Dogfio 🐶📱

Aplicación iOS desarrollada como parte de un challenge técnico. Muestra una lista de perros basada en una fuente externa, con soporte para búsqueda, detalle y almacenamiento local. Se enfoca en UI, arquitectura limpia y código mantenible.

---

## 🧠 Arquitectura

- **MVVM**
- Persistencia local con **Core Data**
- Sin dependencias externas
- 100% programático con **UIKit**

---

## 🔧 Tecnologías utilizadas

- Swift 5
- UIKit
- URLSession
- Core Data
- Xcode 14.2+
- API: [Lista de perros en JSONBlob](https://jsonblob.com/api/1151549092634943488)

---

## 🧩 Funcionalidades implementadas

- ✅ Listado de perros con diseño tipo tarjeta
- ✅ Filtro en tiempo real por nombre (search bar)
- ✅ Vista de detalle con imagen, descripción y edad
- ✅ Navegación embebida en `UINavigationController`
- ✅ Pull-to-refresh integrado
- ✅ Almacenamiento local tras primer fetch con bandera en `UserDefaults`

---

## 🧪 Pruebas Unitarias ✅

---

## 📦 Persistencia

- La primera vez que se abre la app, se hace una petición `GET` para obtener la lista de perros.
- La información se guarda en **Core Data**.
- En ejecuciones posteriores, la app carga los datos directamente desde la base de datos local.

---

## 🧠 Decisiones técnicas

- Se evitó el uso de librerías externas para demostrar dominio de tecnologías nativas.
- Se organizó el código en capas con responsabilidad única: `View`, `ViewModel`, `Service`, `Model`, `Core Data`.
- Se implementó caché simple para imágenes y manejo de red básico usando `URLSession`.
- Se priorizó una UI **pixel perfect** como se solicitó en el challenge.


---

## ✍️ Autor:

**Jonathan L.**  
