import Navbar from "./Navbar";

export default function Layout({ children }) {
  return (
    <div className="container flex flex-col items-center min-h-screen p-4 mx-auto max-w-7xl">
      <Navbar />
      {children}

    </div>
  )
}
