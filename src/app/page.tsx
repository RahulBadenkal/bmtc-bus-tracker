import dynamic from 'next/dynamic';
import Head from 'next/head';
import React from 'react';

const MapComponent = dynamic(() => import("./_components/map"), { ssr:false })


const Home: React.FC = () => {
  return (
    <div>
      Hello
      <MapComponent />
    </div>
  );
};

export default Home;
