import Head from 'next/head'
import { AppProps } from 'next/app'
import { useMemo } from 'react';
import Layout from '../components/Layout';
import '../styles/index.css'

function MyApp({ Component, pageProps }: AppProps) {
  return (
    <>
      <Head>
        <title>Dinosaurs 'r' Us</title>
        <meta name="viewport" content="initial-scale=1.0, width=device-width" />
      </Head>
      <Layout>
        <Component {...pageProps} />
      </Layout>
    </>
  )
}

export default MyApp
