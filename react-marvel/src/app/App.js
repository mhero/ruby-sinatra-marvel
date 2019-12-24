import React, {useState} from 'react';
import './App.css';
const axios = require('axios').default;

const App = () => {
  const [character, setCharacter] = useState(null);
  const [search, setSearch] = useState(null);
  const [error, setError] = useState(null);

  const getCharacter = () => {
    axios.get(`${process.env.REACT_APP_API_URL}/character?name=${search}`)
    .then(function (response) {
      let character = response.data.data[0].attributes
      setCharacter(character);
      setError(null);
    })
    .catch(function (error) {
      // handle error
      if (error.response.status === 404) {
        setError({status: 404, message: "Character not found"});
      } else {
        setError({status: 500, message: "Error in server, please try again in some minutes"});
      }
      setCharacter(null);
    });
  }

  return (
    <div className="App">
      <div class="search">
        <input type="text" class= "search-input" id="name" name="name" placeholder="Search a Marvel Character"
          onChange={(event) => setSearch(event.target.value) }/>
        <button type="button" onClick={getCharacter}>Search Character</button>
      </div>

      {character && (
        <div class="results">
          <div class="panel character-info">
            <h1>{character.name}</h1>
            <img src= {character.thumbnail} />
            <p>{character.description}</p>
            <button type="button">See stories</button>
          </div>
          <div class="panel stories-info">
            <h1>Stories</h1>
            <table>
              <thead>
                  <tr>
                      <th>Title</th>
                  </tr>
              </thead>
              <tbody>
                  <tr>Title 1</tr>
                  <tr>Title 2</tr>
                  <tr>Title 3</tr>
                  <tr>Title 4</tr>
              </tbody>
            </table>
          </div>
          <div class="panel story-characters-info">
            <h1>Starring</h1>
            <p>Story Characters here</p>
          </div>
        </div>
      )}

      {error && (
        <div class="error-message">
          {error.message}
        </div>
      )}
    </div>
  );
}

export default App;
