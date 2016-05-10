import React from 'react';
import FontAwesome from 'react-fontawesome';

class Pending extends React.Component {
  render() {
    return(
      <div className="text-center">
        <FontAwesome spin name='spinner' size="3x" />
      </div>
    );
  }
}

export default Pending;
