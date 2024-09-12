import type { SchemaService } from '@ember-data/store/types';
import type { ResourceSchema } from '@warp-drive/core-types/schema/fields';
import { Type } from '@warp-drive/core-types/symbols';
import { withDefaults } from '@warp-drive/schema-record/schema';

export type PokemonType =
  | 'Normal'
  | 'Fighting'
  | 'Flying'
  | 'Poison'
  | 'Ground'
  | 'Rock'
  | 'Bug'
  | 'Ghost'
  | 'Steel'
  | 'Fire'
  | 'Water'
  | 'Grass'
  | 'Electric'
  | 'Psychic'
  | 'Ice'
  | 'Dragon'
  | 'Dark'
  | 'Fairy';

type PokemonBaseStats = {
  HP: number;
  Attack: number;
  Defense: number;
  'Sp. Attack': number;
  'Sp. Defense': number;
  Speed: number;
};

type PokemonName = {
  english: string;
  japanese: string;
  chinese: string;
  french: string;
};

type PokemonEvolution = {
  prev: [string, string];
  next: [string, string][];
};

type PokemonProfile = {
  height: string;
  weight: string;
  egg: string[];
  ability: [string, string][];
};

type PokemonImage = {
  sprite: string;
  thumbnail: string;
  hires: string;
};

export type Pokemon = Readonly<{
  id: string;
  $type: 'pokemon';

  name: Readonly<PokemonName>;
  description: string;
  type: Readonly<PokemonType[]>;
  base: Readonly<PokemonBaseStats>;
  species: string;
  evolution: Readonly<PokemonEvolution>;

  profile: Readonly<PokemonProfile>;
  image: Readonly<PokemonImage>;
  gender: string;

  [Type]: 'pokemon';
}>;

const PokemonBaseStatsSchema: ResourceSchema = {
  identity: null,
  type: 'pokemon-base-stats',
  fields: [
    {
      kind: 'field',
      name: 'HP',
    },
    {
      kind: 'field',
      name: 'Attack',
    },
    {
      kind: 'field',
      name: 'Defense',
    },
    {
      kind: 'field',
      name: 'Sp. Attack',
    },
    {
      kind: 'field',
      name: 'Sp. Defense',
    },
    {
      kind: 'field',
      name: 'Speed',
    },
  ],
};

const PokemonNameSchema: ResourceSchema = {
  identity: null,
  type: 'pokemon-name',
  fields: [
    {
      kind: 'field',
      name: 'english',
    },
    {
      kind: 'field',
      name: 'japanese',
    },
    {
      kind: 'field',
      name: 'chinese',
    },
    {
      kind: 'field',
      name: 'french',
    },
  ],
};

const PokemonEvolutionSchema: ResourceSchema = {
  identity: null,
  type: 'pokemon-evolution',
  fields: [
    {
      kind: 'array',
      name: 'prev',
    },
    {
      kind: 'array',
      name: 'next',
    },
  ],
};

const PokemonProfileSchema: ResourceSchema = {
  identity: null,
  type: 'pokemon-profile',
  fields: [
    {
      kind: 'field',
      name: 'height',
    },
    {
      kind: 'field',
      name: 'weight',
    },
    {
      kind: 'array',
      name: 'egg',
    },
    {
      kind: 'array',
      name: 'ability',
    },
  ],
};

const PokemonImageSchema: ResourceSchema = {
  identity: null,
  type: 'pokemon-image',
  fields: [
    {
      kind: 'field',
      name: 'sprite',
    },
    {
      kind: 'field',
      name: 'thumbnail',
    },
    {
      kind: 'field',
      name: 'hires',
    },
  ],
};

const PokemonSchema = withDefaults({
  type: 'pokemon',
  fields: [
    {
      kind: 'schema-object',
      name: 'name',
      type: 'pokemon-name',
    },
    {
      kind: 'field',
      name: 'description',
    },
    {
      kind: 'array',
      name: 'type',
    },
    {
      kind: 'schema-object',
      name: 'base',
      type: 'pokemon-base-stats',
    },
    {
      kind: 'field',
      name: 'species',
    },
    {
      kind: 'schema-object',
      name: 'evolution',
      type: 'pokemon-evolution',
    },
    {
      kind: 'schema-object',
      name: 'profile',
      type: 'pokemon-profile',
    },
    {
      kind: 'schema-object',
      name: 'image',
      type: 'pokemon-image',
    },
    {
      kind: 'field',
      name: 'gender',
    },
  ],
});

export function register(schema: SchemaService) {
  schema.registerResources([
    PokemonBaseStatsSchema,
    PokemonNameSchema,
    PokemonEvolutionSchema,
    PokemonProfileSchema,
    PokemonImageSchema,
    PokemonSchema,
  ]);
}
