import type { TOC } from '@ember/component/template-only';

const LoadingBar: TOC<object> = <template>
  <div class='absolute right-0 top-0 w-full'>
    <div class='h-1.5 w-full overflow-hidden bg-pink-100'>
      <div
        class='h-full w-full origin-left-right animate-progress bg-pink-500'
      ></div>
    </div>
  </div>
</template>;

export default LoadingBar;
