# Crear el contenido del archivo TODO en formato Markdown
todo_md_content = """# ✅ Correcciones Grupo 3 – To-Do List

## 🧪 Funcionalidad y UX
- [x] Corregir error de inicio de sesión con usuarios creados en versiones anteriores (rompe retrocompatibilidad). (CHEQUEAR)
- [ ] Mostrar requisitos para participar en todos los voluntariados (no solo en “Voluntariado de prueba 1b”). -> Rehacer todos en la BD con un script?
- [ ] Asignar direcciones diferentes a los voluntariados de prueba.
- [x] Corregir márgenes del radio group según el Design System.
- [x] Corregir márgenes en la card de detalle de perfil.
- [x] Permitir que presionar Enter en el último campo de inicio de sesión envíe el formulario.
- [x] Corregir márgenes de la vista “completar perfil” para respetar el Design System.
- [ ] Prevenir error momentáneo al cargar voluntariados tras crear cuenta nueva sin completar perfil.
- [ ] Evitar re-render innecesario al dar like en cards de voluntariados (con cuenta nueva).
- [ ] Corregir error al navegar a novedades en cuentas nuevas sin perfil completo.
- [ ] Revisar manejo de sesión para cuentas recién creadas.
- [x] Corregir márgenes del modal de perfil según el Design System.
- [ ] Reemplazar logo de baja calidad por uno de mejor resolución.
- [x] Corregir actualización inconsistente de email (aparece erróneamente como mail primario en la sesión tras editar perfil).

## 🔗 Deep Linking
- [~] Hacer que los deep links funcionen en dispositivos físicos. TESTEAR IOS
- [x] Documentar la estrategia de deep linking (ej. agregar links verificados en Android).
- [x] Corregir funcionamiento de deep links para la próxima entrega.

## 📝 Documentación y Código
- [x] Corregir errores de formato Markdown en el README.
- [x] Separar sección de aceptación de voluntariados en README y enlazarla desde “How to test push notifications”.
- [x] Agregar nueva línea al final del archivo en `.fvmrc`, `.gitignore`, `app_routes.dart`, `trim_converter.dart`, `novedad.dart`, etc. (recomendar linter/IDE rule).
- [x] Unificar idioma en los íconos (`app_icons.dart`) y en los modelos (evitar mezclar inglés y español).
- [x] Eliminar comentarios redundantes en español en modelos.
- [x] Decidir entre español o inglés como idioma general del código/documentación.
- [ ] Mantener consistencia entre la versión del tag/release y la del `pubspec.yaml`.