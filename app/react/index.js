import RWR from 'react-webpack-rails';
RWR.run();

import DownloadAt from './components/download_at';
RWR.registerComponent('DownloadAt', DownloadAt);

import PosterImage from './components/poster_image';
RWR.registerComponent('PosterImage', PosterImage);

import MomentDate from './components/moment_date';
RWR.registerComponent('MomentDate', MomentDate);

import MovieSearch from './components/movie_search';
RWR.registerComponent('MovieSearch', MovieSearch);
