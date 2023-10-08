<a name="top"></a>

<h1 align="center">
  <strong><span>Bootcamp Desarrollo de Apps Móviles</span></strong>
</h1>

---

<p align="center">
  <strong><span style="font-size:20px;">Módulo: Patrones de diseño</span></strong>
</p>

---

<p align="center">
  <strong>Autor:</strong> Salva Moreno Sánchez
</p>

<p align="center">
  <a href="https://www.linkedin.com/in/salvador-moreno-sanchez/">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn">
  </a>
</p>

## Índice
 
* [Herramientas](#herramientas)
* [Práctica: Pokédex App empleando MVVM](#practica)
	* [Descripción](#descripcion) 
	* [Características](#caracteristicas)
	* [Problemas, decisiones y resolución](#problemas)
		* [Múltiples llamadas a la API en un bucle](#problemas1)
		* [Algoritmo de búsqueda para el `UISearchController` (similitud de Jaccard)](#problemas2)
		* [Almacenamiento de los datos de la API](#problemas3)

<a name="herramientas"></a>
## Herramientas

<p align="center">

<a href="https://www.apple.com/es/ios/ios-17/">
   <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white" alt="iOS">
 </a>
  
 <a href="https://www.swift.org/documentation/">
   <img src="https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
 </a>
  
 <a href="https://developer.apple.com/xcode/">
   <img src="https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white" alt="XCode">
 </a>
  
</p>

<a name="practica"></a>
## Práctica: Pokédex App empleando MVVM

![Demo app gif](images/demoApp.gif)

<a name="descripcion"></a>
### Descripción

Como práctica final del módulo de *Patrones de diseño* del *Bootcamp* en Desarrollo de Apps Móviles, se nos ha propuesto el desarrollo de una **aplicación iOS**, cuyo principal objetivo es la implementación del **patrón de diseño MVVM**, en la que se debe crear una vista *Splash*, un *Home* que liste personajes con imagen y texto, y que al pulsar en ellos se navegue al detalle del mismo.

En mi caso, he decidido realizar una **aplicación que consuma la API Rest de Pokémon** ([PokéApi](https://pokeapi.co)), con un **diseño inspirado en el [concepto creativo](https://dribbble.com/shots/20298235-Pokedex-App)** del usuario llamado [UIuxcreative](https://dribbble.com/rkmhrzn18) de la web [Dribbble](https://dribbble.com). Todo ello construido de forma **100% programática**.

<a name="caracteristicas"></a>
### Características

En líneas generales, la aplicación de puede dividir en las siguientes vistas:

* ***Splash Screen:*** conexión de la vista *LaunchScreen* (en la que se ha empleado una foto de <a href="https://unsplash.com/es/@steven3466?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Steven Cordes</a> de <a href="https://unsplash.com/es/fotos/S0j5lxoEwPo?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a> para el fondo) con el `UIViewController` correspondiente al *Splash*, creando un efecto de carga con un `UIActivityIndicatorView` para traer los datos de la API a la aplicación. Una vez obtenidos, se navega al *Home*.
* ***Home:*** `UITableView` con celdas personalizadas que alberga un listado de Pokémon. Además, se incluye un `UISearchController` para realizar búsquedas de Pokémon concretos que emplea el algoritmo de similitud de Jaccard.
* ***Detail:***: detalle del Pokémon en el que se incluye su foto, nombre, tipo, peso, altura, ataque, defensa y una pequeña descripción. Todo ello alimentado por datos de la API Rest y respondiendo al diseño creativo de inspiración escogido y anteriormente mencionado.

Por otro lado, se debe destacar que se emplea una clase llamada *Mapper* que se encarga de **adaptar el modelo de datos general al modelo de cada vista**, que se aplica **persistencia de datos de forma manual** con una clase "almacén" y que se ha atendido a la **adaptación de la aplicación para su uso tanto para *light mode* como para *dark mode*.**

<a name="problemas"></a>
### Problemas, decisiones y resolución

<a name="problemas1"></a>
#### Múltiples llamadas a la API en un bucle

Por necesidades de la Pokémon API, en la que necesitaba recoger los datos específicos de múltiples Pokémon para poder reflejarlos en el `UITableView`, me encontré en la tesitura de hacer una **llamada en bucle**.

Tras realizar una investigación acerca de los métodos y funciones que podía realizar, me decidí por implementar un **`DispatchGroup`, cuya estructura permite controlar un grupo de tareas asincrónicas**:

```swift
let dispatchGroup = DispatchGroup()
```

A continuación, en un bucle se llama al método `enter()` para indicar que se ha iniciado una nueva tarea. Se realiza la llamada a la API y se emplea `defer` para aseguranos de que siempre se llame al método `leave()` del `DispatchGroup`, independientemente de si la solicitud fue exitosa o no.

```swift
pokemonList.forEach { pokemon in
    dispatchGroup.enter()
    APIClient.shared.getPokemonData(with: pokemon.url) { result in
        defer {
            dispatchGroup.leave()
        }
        switch result {
            case .success(let pokemonData):
                pokemonDataList.append(pokemonData)
            case .failure(let error):
                print(error.localizedDescription)
        }
    }
}
```

Después de que se hayan iniciado todas las tareas (una para cada Pokémon) y se hayan completado, se usa `dispatchGroup.notify()` para especificar un bloque de código que se ejecutará cuando todas las tareas hayan terminado.

```swift
dispatchGroup.notify(queue: .main) { [weak self] in
    // ...
    self?.apiCallFinished()
}
```

<a name="problemas2"></a>
#### Algoritmo de búsqueda para el `UISearchController` (similitud de Jaccard)

Debido a que la propia API de Pokémon no tiene un espacio dedicado a búsquedas y que devuelvan coincidencias, he elaborado un algoritmo de búsqueda para el `UISearchController` que he implementado en la *Home*, justo encima de la `UITableView`. Para ello, he usado el **algoritmo de similitud de Jaccard**, el cual pude estudiar en el Grado de Ingeniería de Informática. A grandes rasgos, el algoritmo de similitud de Jaccard se utiliza para **medir la similitud entre dos conjuntos**, calculándose a través de la división del número de elementos en la intersección de los conjuntos por el número de elementos en la unión de los conjuntos.

Aquí dejo la función para calcular la similitud de Jaccard entre dos `String` que he empleado en la aplicación:

```swift
private static func jaccardSimilarity(_ s1: String, _ s2: String) -> Double {
    let set1 = Set(s1)
    let set2 = Set(s2)
    let intersection = set1.intersection(set2)
    let union = set1.union(set2)
    
    return Double(intersection.count) / Double(union.count)
}
```

<a name="problemas3"></a>
#### Almacenamiento de los datos de la API

A día de hoy, 8 de octubre de 2023, no me he adentrado en *Core Data* para persistir datos. Por ello, he querido implementar de forma manual la persistencia de los datos recibidos por la API, decodificados en mi propio modelo, en una clase con funciones estáticas llamada `DataPersistance`. Esto me ha facilitado el acceso a los datos y que, como puente a los modelos de datos empleados tanto en el *Home* como en el *Detail*, he usado un *Mapper*. De esta forma, aun sacrificando la memoria que pueda consumir el hecho de retener los datos de la API en una clase, he podido poner en práctica el mapeo de los datos para proporcionarle a cada *ViewModel* aquellos que solo son necesarios para reflejar en la vista.

---

[Subir ⬆️](#top)

---
