/*
  This script is used to generate the JSON files for the API.
  It reads the pokemons.json file and generates the list and single files.

  The list files are paginated with 48 items per page.
  The single files are used to get the details of a specific pokemon.

  In the process, the data is transformed to match the JSON:API specification.

  Currently it does not treat prev and next evolutions as relationships
  though it is possible to do so and we may want to add that to the API in the future.
*/
import { readFileSync, writeFileSync, existsSync, mkdirSync } from 'fs';

const raw = JSON.parse(readFileSync('./public/pokemons.json', 'utf8'));

const POKEMON = raw.data.map((pokemon) => {
  const id = String(pokemon.id);
  delete pokemon.id;
  return {
    id,
    type: 'pokemon',
    attributes: pokemon,
  };
});
const SLICES = [];
const sliceSize = 48;

function links(slice) {
  slice.links.self = `/api/pokemon/list/${slice.meta.currentPage}.json`;
  slice.links.prev = slice.meta.currentPage === 1 ? null : `/api/pokemon/list/${slice.meta.currentPage - 1}.json`;
  slice.links.next = slice.meta.currentPage === slice.meta.totalPages ? null : `/api/pokemon/list/${slice.meta.currentPage + 1}.json`;
  slice.links.first = `/api/pokemon/list/1.json`;
  slice.links.last = `/api/pokemon/list/${slice.meta.totalPages}.json`;
}

function meta(slice, index) {
  slice.meta.currentPage = index + 1;
  slice.meta.totalPages = SLICES.length;
  slice.meta.total = POKEMON.length;
  slice.meta.estimatedTotal = POKEMON.length;
  slice.meta.page = { size: slice.data.length, total: POKEMON.length, estimatedTotal: POKEMON.length }
}

function ensureDirectoryExistence(dirname) {
  if (existsSync(dirname)) {
    return true;
  }

  mkdirSync(dirname, { recursive: true });
}

function populateSlices() {
  const temp = POKEMON.slice();

  while (temp.length) {
    SLICES.push({
      data: temp.splice(0, sliceSize),
      meta: {},
      links: {},
    });
  }

  SLICES.forEach((slice, index) => {
    meta(slice, index);
    links(slice);
  });

  SLICES.forEach((slice, index) => {
    writeFileSync(`./public/api/pokemon/list/${index + 1}.json`, JSON.stringify(slice));

    if (index === 0) {
      writeFileSync('./public/api/pokemon/list.json', JSON.stringify(slice));
    }
  });
}

ensureDirectoryExistence('./public/api/pokemon/list');
ensureDirectoryExistence('./public/api/pokemon/single');
populateSlices();

POKEMON.forEach((pokemon) => {
  writeFileSync(`./public/api/pokemon/single/${pokemon.id}.json`, JSON.stringify({ data: pokemon }));
});
