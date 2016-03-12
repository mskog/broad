import React from 'react';
import { connect, PromiseState } from 'react-refetch';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import Button from 'react-bootstrap/lib/Button';

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

  loadDetails() {
    this.setState({loadDetails: true})
    this.props.lazyReleaseFetch();
  }

  render() {
    const { releaseFetch } = this.props

    var loadDetailsButton = ''
    if (this.state.loadDetails == false){
      loadDetailsButton = <Button bsSize='small' onClick={this.loadDetails.bind(this)}>Check Releases</Button>;
    }

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
          {loadDetailsButton}
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
