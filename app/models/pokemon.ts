import Model, { attr } from '@ember-data/model';
import { Type } from '@warp-drive/core-types/symbols';

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
