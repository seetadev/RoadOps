import PageHeading from "../components/PageHeading";

export default function Home() {
  return (
    <main className="flex flex-col gap-8">
      <PageHeading>Dinosaurs 'r' Us</PageHeading>

      <div className="basis-1/4">
        <button
          type="button"
          className="inline-flex items-center px-4 py-2 text-sm font-medium text-indigo-700 bg-indigo-100 border border-transparent rounded-md cursor-pointer hover:bg-indigo-200 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Mint a DINO! 🦖
        </button>
      </div>

      <hr />
    </main>
  )
}
