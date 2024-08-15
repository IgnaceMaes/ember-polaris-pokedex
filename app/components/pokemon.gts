
import type { TOC } from '@ember/component/template-only';

interface PokemonSignature {
  Args: { pokemon: { name: string; } };
}


const Pokemon: TOC<PokemonSignature> =
<template>
  <h3>{{@pokemon.name.english}}</h3>

  <style>
    h3 {
      color: red;
    }
  </style>
</template>
;

export default Pokemon;
