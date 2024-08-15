import BaseRequestManager from '@ember-data/request';
import Fetch from '@ember-data/request/fetch';
import { JsonSuffixHandler } from 'ember-embroider-pokedex/utils/handlers';

export default class RequestManager extends BaseRequestManager {
  constructor(args) {
    super(args);
    debugger;
    console.log('RequestManager constructor');

    this.use([JsonSuffixHandler, Fetch]);
  }
}
