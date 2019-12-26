# ItunesApiSearch

ItunesApiSearch es una aplicación que permite buscar canciones en el API de Itunes y desplegar los resultados en una tabla.
Una vez encontrada la cancion, la puedes seleccionar y te llevará al detalle de la cancion, permitiendote ver información adicional como por ejemplo el nombre del disco y que otras canciones aparecen en el mismo disco. Al presionar escuchar, podrás
escuchar el preview de la cancion.

La aplicacion tiene la capacidad de guardar información utilizando el framework CoreData de Apple por tanto tus búsquedas quedaran almacenadas y seran desplegadas en la misma aplicacion.

Para el desarrollo de la APP se utilizo CocoaPods para la gestión de dependencias, en este caso se utilizó "Alamofire" para poder realizar las peticiones al API de Itunes, para mayor información visitar [CocoaPods](https://cocoapods.org/)

Para ejecutar la aplicacion debes clonar este repositorio luego en una terminal en la carpeta raiz ejecutar `pod install`, una vez terminado el proceso con el XCode deberas abrir el archivo **ItunesApiSearch.xcworkspace**
