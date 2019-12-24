import React, {useState} from 'react';
import './App.css';
const axios = require('axios').default;

const App = () => {
  const [character, setCharacter] = useState(null);
  const [search, setSearch] = useState(null);
  const [error, setError] = useState(null);


  const onClick = () => {
    axios.get(`${process.env.REACT_APP_API_URL}/character?name=${search}`)
    .then(function (response) {
      let character = response.data.data[0].attributes
      setCharacter(character);
    })
    .catch(function (error) {
      // handle error
      if (error.response.status === 404) {
        setError({status: 404, message: "Character not found"});
      } else {
        setError({status: 500, message: " Error in server, please try again in some minutes"});
      }
      setCharacter(null);
    });
  }

  return (
    <div className="App">
      <input type="text" id="name" name="name" placeholder="Search a Marvel Character"
        onChange={(event) => setSearch(event.target.value) }/>
      <button type="button" onClick={onClick}>Search Character</button>

      {character && (
        <>
          <img src= {character.thumbnail} />

          <ul>
            <li>{character.name}</li>
            <li>{character.description}</li>
          </ul>
        </>
      )}

      {error && (
        <>
          {error.message}
        </>
      )}
    </div>
  );
}

export default App;