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
* [Práctica: Pokédex App](#practica)
	* [Descripción](#descripcion) 
	* [Características](#caracteristicas)
	* [Problemas, decisiones y resolución](#problemas)
		* [Múltiples llamadas a la API en un bucle](#problemas1)

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
## Práctica: Pokédex App

![Demo app gif](images/demoApp.gif)

<a name="descripcion"></a>
### Descripción

Como práctica final al módulo de *Patrones de diseño* del *Bootcamp* en Desarrollo de Apps Móviles, se nos ha propuesto el desarrollo de una **aplicación iOS**, cuyo principal objetivo es la implementación del **patrón de diseño MVVM**, además de crear una vista *Splash*, un *Home* que liste personajes con imagen y texto, y que al pulsar en ellos se navegue al detalle del mismo.

En mi caso, he decidido realizar una **aplicación que consuma la API Rest de Pokémon** ([PokéApi](https://pokeapi.co)), con un **diseño inspirado en el [concepto creativo](https://dribbble.com/shots/20298235-Pokedex-App)** del usuario llamado [UIuxcreative](https://dribbble.com/rkmhrzn18) de la web [Dribbble](https://dribbble.com).

<a name="caracteristicas"></a>
### Características 

<a name="problemas"></a>
### Problemas, decisiones y resolución

<a name="problemas1"></a>
#### Múltiples llamadas a la API en un bucle

Por necesidades de la Pokémon API, en la que necesitaba recoger los datos específicos de múltiples pokémon para poder reflejarlos en el `UITableView`, me encontré en la tesitura de hacer una llamada en bucle.

Tras realizar una investigación acerca de los métodos y funciones que podía realizar, me decidí por implementar un `DispatchGroup`, cuya estructura permite controlar un grupo de tareas asincrónicas:

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

---

[Subir ⬆️](#top)

---

# Resources

Foto de <a href="https://unsplash.com/es/@steven3466?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Steven Cordes</a> en <a href="https://unsplash.com/es/fotos/S0j5lxoEwPo?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>

* [Inspiración UI](https://dribbble.com/shots/20298235-Pokedex-App)
