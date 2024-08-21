const images = import.meta.glob('../assets/images/*.(svg|png)', {
  eager: true,
});

export default function importAsset(assetName: string): string {
  const imagePath = images[`../assets/images/${assetName}`] as
    | { default: string }
    | undefined;
  return imagePath?.default ?? '';
}
