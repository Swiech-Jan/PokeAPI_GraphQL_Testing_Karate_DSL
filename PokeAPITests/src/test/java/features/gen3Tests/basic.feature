Feature: Testing graphQL poke-api TC1Test1

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
        And header Accept = 'application/json'
        When method POST
        Then status 200

        #Test if array of returned elements is NOT empty
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
        And header Accept = 'application/json'
        When method POST
        Then status 200

        #Test if type of "name", "id" is consisted with type in schema.
        And match each response.data.gen3_species[*].name == '#string'
        And match each response.data.gen3_species[*].id == '#number'


