import React from 'react';
import { connect, PromiseState } from 'react-refetch';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';

import Release from './release';
import Pending from './pending';

class ReleaseDetails extends React.Component {
  constructor(props) {
     super(props);
     this.state = {loadDetails: props.loadDetails};
  }

  componentWillMount() {
   if (this.state.loadDetails == true){
     this.props.lazyReleaseFetch();
   }
  }

  render() {
    const { releaseFetch } = this.props

    var bestRelease = '';
    if (releaseFetch !== undefined){
      if (releaseFetch.fulfilled){
        bestRelease = <Release {...releaseFetch.value} imdb_id={this.props.imdb_id} />;
      } else{
        bestRelease = <Pending />
      }
    }

    return(
      <Row>
        <Col md={12}>
          {bestRelease}
        </Col>
      </Row>
    );
  }
}

export default ReleaseDetails;

export default connect(props => ({
  lazyReleaseFetch: () => ({
    releaseFetch: `/api/v1/movie_acceptable_releases/${props.imdb_id}`
  })
}))(ReleaseDetails)
