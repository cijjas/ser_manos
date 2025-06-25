# ✅ Correcciones Grupo 3 – To-Do List

## 🧪 Funcionalidad y UX
- [ ] Corregir navegación entre inputs en formularios (Tab o Enter no cambia de input).
- [ ] Ajustar separación entre chip de vacantes y títulos según el Design System.
- [ ] Mostrar voluntariado en actividad luego de postularse y ser confirmado. -> No la entendi
- [ ] El ícono de “list view” en la search bar debe tener funcionalidad o eliminarse.
- [x] Implementar técnica de `debounce` en el buscador.
- [x] Corregir animación indeseada al presionar las tabs de navegación en Android.
- [x] Hacer que el fondo de las cards de noticias también sea un touch target.
- [ ] Manejar error 503 al subir imagen de voluntariado.
- [ ] Evitar doble subida de foto en la vista de completar perfil.
- [ ] El botón “guardar perfil” no debe estar habilitado si no hay cambios.
- [ ] Unificar idioma en los textos de validación (no mezclar inglés y español).
- [ ] Corregir re-render de todas las cards al likear una (mejorar manejo de estado).
- [ ] Permitir editar datos del perfil sin necesidad de subir nueva foto.
- [ ] Evitar mostrar errores crudos de Firebase mediante snackbars.
- [ ] Arreglar subida de fotos vía cámara en Android (error actual).
- [ ] Corregir error al ingresar a vistas de detalle de voluntariados en producción.
- [ ] Implementar vista para abandonar voluntariado actual. -> No la entendi
- [ ] Reemplazar coordenadas por nombre de calle en el campo dirección.

## 🧾 Documentación
- [x] Usar `markdownlint` para mejorar formato del README.
- [ ] Explicar cómo crear una noticia que dispare la función de notificación en Firebase.
- [x] Describir cómo aceptar un voluntariado en el README.
- [ ] Mejorar especificidad de métrica `screen_view`.
- [ ] Corregir typo en nombre del proyecto de Firebase.
- [x] Asegurarse de agregar a los profesores como editores en Firebase.

## 🧹 Limpieza del Proyecto
- [x] No incluir directorios innecesarios (`windows`, `macos`, `linux`) si no aplican.
- [~] Eliminar archivos irrelevantes como `todo.txt` y `preguntas.txt`.
- [ ] Explicar propósito del directorio `coverage` o eliminarlo si no se usa.
- [ ] Eliminar imports duplicados o no utilizados (`flutter analyze`).
- [ ] Eliminar `prints` en código productivo.
- [ ] Agregar `const` en constructores donde corresponda.
- [ ] Renombrar estado `applied` a `pending`.
- [ ] Eliminar comentarios generados por LLMs.
- [ ] Cambiar el uso de `flutter pub run build_runner build` a `dart run build_runner build`.

## 🛠️ Mejores Prácticas
- [ ] Corregir error al correr `flutter pub get` por primera vez.
- [ ] Centralizar rutas y assets en clases como `AppAssets` y `AppRoutes` (evitar strings hardcodeadas).
- [ ] Usar un único idioma para rutas (`/home/profile`, `/home/postularse`, etc.).
- [ ] Resolver los issues detectados por `flutter analyze`.