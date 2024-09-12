import { defineConfig } from "vite";
import {
  resolver,
  hbs,
  scripts,
  templateTag,
  optimizeDeps,
  compatPrebuild,
  assets,
  contentFor,
} from "@embroider/vite";
import { resolve } from "path";
import { babel } from "@rollup/plugin-babel";
import tailwindcss from "tailwindcss";

const root = "tmp/rewritten-app";
const extensions = [
  ".mjs",
  ".gjs",
  ".js",
  ".mts",
  ".gts",
  ".ts",
  ".hbs",
  ".json",
];


export default defineConfig(({ mode }) => {
  const embroiderDeps = optimizeDeps();
  embroiderDeps.exclude = embroiderDeps.exclude ?? [];
  embroiderDeps.exclude.push('!data-worker*')
  embroiderDeps.exclude.push('!*data-worker')

  return {
    root,
    cacheDir: resolve("node_modules", ".vite"),
    resolve: {
      extensions,
    },
    plugins: [
      hbs(),
      templateTag(),
      scripts(),
      resolver(),
      compatPrebuild(),
      assets(),
      contentFor(),

      babel({
        babelHelpers: "runtime",
        extensions,
      }),
    ],
    optimizeDeps: embroiderDeps,
    publicDir: resolve(process.cwd(), "public"),
    server: {
      port: 4200,
      watch: {
        ignored: ["!**/tmp/rewritten-app/**"],
      },
    },
    build: {
      outDir: resolve(process.cwd(), "dist"),
      rollupOptions: {
        input: {
          main: resolve(root, "index.html"),
          ...(shouldBuildTests(mode)
            ? { tests: resolve(root, "tests/index.html") }
            : undefined),
        },
      },
    },
    css: {
      postcss: {
        plugins: [tailwindcss()],
      },
    },
  };
});

function shouldBuildTests(mode) {
  return mode !== "production" || process.env.FORCE_BUILD_TESTS;
}
