
import type { TOC } from '@ember/component/template-only';
import type PokemonModel from 'ember-embroider-pokedex/models/pokemon';

interface PokemonSignature {
  Args: { pokemon: PokemonModel };
}


const Pokemon: TOC<PokemonSignature> =
<template>
  <div class="card">
    <h3>{{@pokemon.name.english}}</h3>
    <img src={{@pokemon.image.thumbnail}} />
  </div>

  <style>
    h3 {
      font-weight: bold;
      font-family: 'Inter', sans-serif;
    }

    .card {
      background-color: #f7f9ff;
      border-radius: 6px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      padding: 1rem;
    }
  </style>
</template>
;

export default Pokemon;
