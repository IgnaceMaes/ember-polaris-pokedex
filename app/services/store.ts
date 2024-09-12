import JSONAPICache from '@ember-data/json-api';
import RequestManager from '@ember-data/request';
import { CachePolicy } from '@ember-data/request-utils';
import {
  registerDerivations,
  SchemaService,
} from '@warp-drive/schema-record/schema';
import BaseStore, { CacheHandler } from '@ember-data/store';
import type { CacheCapabilitiesManager } from '@ember-data/store/types';

import { register as registerPokemon } from 'ember-polaris-pokedex/schemas/pokemon';
import type { StableRecordIdentifier } from '@warp-drive/core-types';
import type { SchemaRecord } from '@warp-drive/schema-record/record';
import {
  instantiateRecord,
  teardownRecord,
} from '@warp-drive/schema-record/hooks';
import { Fetch } from 'ember-polaris-pokedex/data-worker/fetch';

export default class Store extends BaseStore {
  requestManager = new RequestManager().use([Fetch]).useCache(CacheHandler);

  lifetimes = new CachePolicy({
    apiCacheHardExpires: 1000 * 60 * 60 * 48, // 48 hours
    apiCacheSoftExpires: 1000 * 60 * 60, // 1 hour
  });

  createCache(capabilites: CacheCapabilitiesManager) {
    return new JSONAPICache(capabilites);
  }

  createSchemaService() {
    const schema = new SchemaService();

    registerDerivations(schema);
    registerPokemon(schema);

    return schema;
  }

  instantiateRecord(
    identifier: StableRecordIdentifier,
    createRecordArgs: { [key: string]: unknown },
  ) {
    return instantiateRecord(this, identifier, createRecordArgs);
  }

  teardownRecord(record: SchemaRecord): void {
    teardownRecord(record);
  }
}
