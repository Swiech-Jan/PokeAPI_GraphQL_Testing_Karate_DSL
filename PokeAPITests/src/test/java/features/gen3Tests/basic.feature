Feature: Basic tests for genIII Pokemon's

    Background:
        * url 'https://beta.pokeapi.co/graphql/v1beta'

    Scenario: Gets all the pokemon of generation III and check the response
        Given text query =
        """
            query {
            gen3_species: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-iii"}}}, order_by: {id: asc}) {
            id
            name
              }
            }
        """
        And request { query: '#(query)' }
        When method POST
        Then status 200
        And match response.data.gen3_species != []

    Scenario: Gets all the pokemon of generation III and check the response

        Given text query =
        """
            query {
            gen3_species: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-iii"}}}, order_by: {id: asc}) {
            id
            name
              }
            }
        """
        And request { query: '#(query)' }
        When method POST
        Then status 200
        And match each response.data.gen3_species[*].name == '#string'
        And match each response.data.gen3_species[*].id == '#number'

    Scenario: Gets all the pokemon of generation III and check the response
        Given text query =
            """
            query {
            gen3_species: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-iii"}}}, order_by: {id: asc}) {
            id
            name
              }
            }
        """
        And request { query: '#(query)' }
        And header Accept = 'application/json'
        When method POST
        Then status 200
        And match response.data.gen3_species[*].name contains "skitty"

    Scenario: Gets all the pokemon of generation III and check the response
        Given text query =
        """
            query {
            gen3_species: pokemon_v2_pokemonspecies(where: {pokemon_v2_generation: {name: {_eq: "generation-iii"}}}, order_by: {id: asc}) {
            id
            name
              }
            }
        """
        And request { query: '#(query)' }
        And header Accept = 'application/json'
        When method POST
        Then status 200
        And match response.data.gen3_species[*].name !contains "pikachu"

    Scenario: Count pokemon species from generation III and check the response
        Given text query =
        """
            query {
            pokemon_v2_pokemonspecies_aggregate(where: {pokemon_v2_generation: {name: {_eq: "generation-iii"}}}) {
            aggregate {
              count
                }
              }
            }
        """
        And request { query: '#(query)' }
        And header Accept = 'application/json'
        When method POST
        Then status 200
        And match response.data.pokemon_v2_pokemonspecies_aggregate.aggregate.count == 135


    Scenario Outline: pokemon_v2_generation: <count>
        Given text query =
        """
            query {
            pokemon_v2_pokemonspecies_aggregate(where: {pokemon_v2_generation: {name: {_eq: "<generation>" }}}) {
            aggregate {
              count
                }
              }
            }
        """
        And request { query: '#(query)' }
        And header Accept = 'application/json'
        When method POST
        Then status 200
        Then match response.data.pokemon_v2_pokemonspecies_aggregate.aggregate.count == <count>

        Examples:
            | generation     | count |
            | generation-i   | 151   |
            | generation-ii  | 100   |
            | generation-iii | 135   |









