import Model, { attr } from '@ember-data/model';
import { Type } from '@warp-drive/core-types/symbols';

/**
 * Data:
 * {
"id": 1,
"name": {
"english": "Bulbasaur",
"japanese": "フシギダネ",
"chinese": "妙蛙种子",
"french": "Bulbizarre"
},
"type": [
"Grass",
"Poison"
],
"base": {
"HP": 45,
"Attack": 49,
"Defense": 49,
"Sp. Attack": 65,
"Sp. Defense": 65,
"Speed": 45
},
"species": "Seed Pokémon",
"description": "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun’s rays, the seed grows progressively larger.",
"evolution": {
"next": [
[
"2",
"Level 16"
]
]
},
"profile": {
"height": "0.7 m",
"weight": "6.9 kg",
"egg": [
"Monster",
"Grass"
],
"ability": [
[
"Overgrow",
"false"
],
[
"Chlorophyll",
"true"
]
],
"gender": "87.5:12.5"
},
"image": {
"sprite": "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/master/images/pokedex/sprites/001.png",
"thumbnail": "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/master/images/pokedex/thumbnails/001.png",
"hires": "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/master/images/pokedex/hires/001.png"
}
},
 */

export type PokemonType = 'Normal' | 'Fighting' | 'Flying' | 'Poison' | 'Ground' | 'Rock' | 'Bug' | 'Ghost' | 'Steel' | 'Fire' | 'Water' | 'Grass' | 'Electric' | 'Psychic' | 'Ice' | 'Dragon' | 'Dark' | 'Fairy';

export default class PokemonModel extends Model {
  @attr declare name: {
    english: string;
    japanese: string;
    chinese: string;
    french: string;
  };

  @attr('string') declare description: string;

  @attr declare type: PokemonType[];

  @attr declare base: {
    HP: number;
    Attack: number;
    Defense: number;
    'Sp. Attack': number;
    'Sp. Defense': number;
    Speed: number;
  };

  @attr declare species: string;

  @attr declare evolution: {
    prev: [string, string];
    next: [string, string][];
  };

  @attr declare profile: {
    height: string;
    weight: string;
    egg: string[];
    ability: [string, string][];
  };

  @attr declare gender: string;

  @attr declare image: {
    sprite: string;
    thumbnail: string;
    hires: string;
  };

  [Type] = 'pokemon' as const;
}
