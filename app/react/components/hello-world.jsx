import React from 'react';

class HelloWorld extends React.Component {
  render() {
    return(
      <div>
        <p>Hello world {this.props.name}</p>
      </div>
    );
  }
}

export default HelloWorld;
