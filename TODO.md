# ✅ Correcciones Grupo 3 – To-Do List

## 🧪 Funcionalidad y UX
- [x] Corregir navegación entre inputs en formularios (Tab o Enter no cambia de input).
- [x] Ajustar separación entre chip de vacantes y títulos según el Design System.
- [x] El ícono de “list view” en la search bar debe tener funcionalidad o eliminarse.
- [x] Implementar técnica de `debounce` en el buscador.
- [x] Corregir animación indeseada al presionar las tabs de navegación en Android.
- [x] Hacer que el fondo de las cards de noticias también sea un touch target.
- [x] Evitar doble subida de foto en la vista de completar perfil.
- [x] El botón “guardar perfil” no debe estar habilitado si no hay cambios.
- [x] Arreglar subida de fotos vía cámara en Android (error actual).
- [x] Permitir editar datos del perfil sin necesidad de subir nueva foto.
- [ ] Unificar idioma en los textos de validación (no mezclar inglés y español).
- [x] Corregir re-render de todas las cards al likear una (mejorar manejo de estado). (NO se re renderizaban, solo aparecia un loading extra del current que las sacaba de lugar)
- [x] Evitar mostrar errores crudos de Firebase mediante snackbars.
- [ ] Corregir error al ingresar a vistas de detalle de voluntariados en producción.
- [x] Reemplazar coordenadas por nombre de calle en el campo dirección.
- [ ] Implementar vista para abandonar voluntariado actual. -> No la entendi. yo tampoco? quizas poruqe no les funcionaba el detalle no podian ver el abandonar voluntariado? no se no entiendo
- [ ] Manejar error 503 al subir imagen de voluntariado. -> No es error del link, si no del proveedor de imágenes que usamos. Usar otro? Usar storage?
- [ ] Mostrar voluntariado en actividad luego de postularse y ser confirmado. -> No la entendi

## 🧾 Documentación
- [x] Usar `markdownlint` para mejorar formato del README.
- [ ] Explicar cómo crear una noticia que dispare la función de notificación en Firebase.
- [x] Describir cómo aceptar un voluntariado en el README.
- [ ] Mejorar especificidad de métrica `screen_view`.
- [x] Corregir typo en nombre del proyecto de Firebase.
- [x] Asegurarse de agregar a los profesores como editores en Firebase.

## 🧹 Limpieza del Proyecto
- [x] No incluir directorios innecesarios (`windows`, `macos`, `linux`) si no aplican.
- [x] Eliminar archivos irrelevantes como `todo.txt` y `preguntas.txt`.
- [ ] Explicar propósito del directorio `coverage` o eliminarlo si no se usa.
- [x] Eliminar `prints` en código productivo. 
- [ ] Agregar `const` en constructores donde corresponda.
- [x] Renombrar estado `applied` a `pending`.
- [ ] Eliminar comentarios generados por LLMs.
- [x] Cambiar el uso de `flutter pub run build_runner build` a `dart run build_runner build --delete-conflicting-outputs`.
    
## 🛠️ Mejores Prácticas
- [ ] Corregir error al correr `flutter pub get` por primera vez.
- [~] Centralizar rutas y assets en clases como `AppAssets` y `AppRoutes` (evitar strings hardcodeadas). -> esta hecho AppRoutes, pero no lo de assets
- [x] Usar un único idioma para rutas (`/home/profile`, `/home/postularse`, etc.).
- [ ] Resolver los issues detectados por `flutter analyze` -> Dejar para el final