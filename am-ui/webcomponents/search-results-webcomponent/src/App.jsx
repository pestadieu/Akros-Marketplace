import './App.css';
import SearchResultList from './SearchResultList';
import ReactDOM from 'react-dom';

class SearchResultsWebComponent extends HTMLElement {
  mountPoint;
  constructor() {
    super();
    this._results = [];
    this._language = '';
  }

  set results(results) {
    this._results = results;
    this.renderComponent();
  }
  get results() {
    return this._results;
  }
  set language(language) {
    this._language = language;
    this.renderComponent();
  }
  get language() {
    return this._language;
  }
  connectedCallback() {
    // Create a ShadowDOM
    const root = this.attachShadow({mode: 'closed'});
    // Create a mount element
    this.mountPoint = document.createElement('div');
    root.appendChild(this.mountPoint);
    const style = document.createElement('style');
  }
  renderComponent() {
    if (this.results !== '' && this.language !== '') {
      const searchResultList = (
        <SearchResultList
          results={this.results}
          language={this.language}
        ></SearchResultList>
      );

      ReactDOM.render(searchResultList, this.mountPoint);
    }
  }
}
customElements.define('search-results-component', SearchResultsWebComponent);

function App() {
  return <search-results-component></search-results-component>;
}

export default App;
