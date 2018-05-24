import React from "react";
import { connect, PromiseState } from "react-refetch";
import Row from "react-bootstrap/lib/Row";
import Col from "react-bootstrap/lib/Col";
import Button from "react-bootstrap/lib/Button";
import PropTypes from "prop-types";

import Details from "./details";
import Pending from "../../pending";

class ReleaseDetails extends React.Component {
  constructor(props) {
    super(props);
    this.state = { loadDetails: props.loadDetails };
  }

  componentDidMount() {
    if (this.state.loadDetails == true && this.props.imdb_id) {
      this.props.lazyDetailsFetch();
    }
  }

  loadDetails() {
    this.setState({ loadDetails: true });
    this.props.lazyDetailsFetch();
  }

  loadDetailsButton() {
    var loadDetailsButton = "";
    if (this.state.loadDetails == false && this.props.imdb_id) {
      loadDetailsButton = (
        <Button bsSize="small" onClick={this.loadDetails.bind(this)}>
          Load details
        </Button>
      );
    }
    return loadDetailsButton;
  }

  detailsAndRelease() {
    const { detailsFetch } = this.props;
    if (detailsFetch === undefined) {
      return "";
    }

    const allFetches = PromiseState.all([detailsFetch]);

    if (allFetches.pending) {
      return <Pending />;
    }

    const [details] = allFetches.value;

    return <div>{this.details(details)}</div>;
  }

  details(details) {
    return <Details {...details} />;
  }

  render() {
    return (
      <Row>
        <Col md={12}>
          {this.loadDetailsButton()}
          {this.detailsAndRelease()}
        </Col>
      </Row>
    );
  }
}

ReleaseDetails.propTypes = {
  imdb_id: PropTypes.string,
  loadDetails: PropTypes.bool,
  detailsFetch: PropTypes.object,
  lazyDetailsFetch: PropTypes.func
};

export default connect(props => ({
  lazyDetailsFetch: () => ({
    detailsFetch: `/api/v1/tv_show_details/${props.imdb_id}`
  })
}))(ReleaseDetails);
