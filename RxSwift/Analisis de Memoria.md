#  Analisis de memoria


Se noto que en el momento de cargar las imagenes al uitableviewcell existe un problema al cargar la imagen debido a que es una url y se obtiene en cada refresh de la celda.
Posible solución seria implementar en la funcion donde se obtiene el objeto del response y consultar en el viewDidLoad() todas las urls y modificar el objeto para cargar la imagen mediante la función creada a partir de la extensión de UIimage

