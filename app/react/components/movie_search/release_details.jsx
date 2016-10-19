import React from 'react';
import { connect, PromiseState } from 'react-refetch';
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';
import Button from 'react-bootstrap/lib/Button';

import Release from './release';
import Details from './details';
import Pending from '../pending';

class ReleaseDetails extends React.Component {
  constructor(props) {
     super(props);
     this.state = {loadDetails: props.loadDetails};
  }

  componentWillMount() {
    if (this.state.loadDetails == true){
      this.props.lazyDetailsFetch();
      this.props.lazyReleaseFetch();
    }
  }

  loadDetails() {
    this.setState({loadDetails: true})
    this.props.lazyReleaseFetch();
    this.props.lazyDetailsFetch();
  }

  loadDetailsButton() {
    var loadDetailsButton = ''
    if (this.state.loadDetails == false){
      loadDetailsButton = <Button bsSize='small' onClick={this.loadDetails.bind(this)}>Check Releases</Button>;
    }
    return loadDetailsButton;
  }

  detailsAndRelease() {
    const { releaseFetch, detailsFetch } = this.props
    if (releaseFetch === undefined || detailsFetch === undefined){
      return "";
    }

    const allFetches = PromiseState.all([releaseFetch, detailsFetch])

    if (allFetches.pending){
      return <Pending />;
    }

    const [release, details] = allFetches.value

    return(
      <div>
        {this.details(details)}
        {this.bestRelease(release)}
      </div>
    )
  }

  bestRelease(release) {
    return <Release {...release} imdb_id={this.props.imdb_id} />;
  }

  details(details) {
    return <Details {...details} />;
  }

  render() {
    return(
      <Row>
        <Col md={12}>
          {this.loadDetailsButton()}
          {this.detailsAndRelease()}
        </Col>
      </Row>
    );
  }
}

export default connect(props => ({
  lazyReleaseFetch: () => ({
    releaseFetch: `/api/v1/movie_acceptable_releases/${props.imdb_id}`
  }),
  lazyDetailsFetch: () => ({
    detailsFetch: `/api/v1/movie_search_details/${props.imdb_id}`
  })
}))(ReleaseDetails)
