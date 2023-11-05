'use client';

import React, { useEffect, useRef } from 'react';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';

const MapComponent: React.FC = () => {
  const mapRef = useRef<L.Map | null>(null); // ref to store the map instance

  useEffect(() => {
    if (mapRef.current === null) {
      // only initialize the map if it hasn't been already
      mapRef.current = L.map('map').setView([12.9716, 77.5946], 13); // Coordinates for Bangalore

      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap contributors',
      }).addTo(mapRef.current);
    }

    return () => {
      // Cleanup map on unmount
      mapRef.current?.remove();
      mapRef.current = null;
    };
  }, []);

  return <div id="map" style={{ height: '60vh', width: '100%' }}></div>;
};

export default MapComponent;
