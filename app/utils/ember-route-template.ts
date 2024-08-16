import Component from '@glimmer/component';
import type Route from '@ember/routing/route';
import type Controller from '@ember/controller';

type ModelFrom<R extends Route> = Awaited<ReturnType<R['model']>>;

export type RouteTemplateSignature<
  R extends Route,
  C extends Controller | undefined = undefined,
> = C extends Controller
  ? {
      Args: {
        model: ModelFrom<R>;
        controller: C;
      };
    }
  : {
      Args: {
        model: ModelFrom<R>;
      };
    };

export class RouteComponent<
  R extends Route,
  C extends Controller | undefined = undefined,
> extends Component<RouteTemplateSignature<R, C>> {}
