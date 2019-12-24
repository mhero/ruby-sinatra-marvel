import React, {useState} from 'react';
import './App.css';
const axios = require('axios').default;

const App = () => {
  const [character, setCharacter] = useState(null);
  const [stories, setStories] = useState(null);
  const [storyCharacters, setStoryCharacters] = useState(null);
  const [search, setSearch] = useState(null);
  const [error, setError] = useState(null);

  const clear = () => {
    setCharacter(null);
    setError(null);
    setStories(null);
    setStoryCharacters(null);
  }

  const updateError = (error, message) => {
    if (error.response != null && error.response.status === 404) {
      setError({status: 404, message: message});
    } else {
      setError({status: 500, message: "Error in server, please try again in some minutes"});
    }
  }

  const getCharacter = () => {
    clear();
    axios.get(`${process.env.REACT_APP_API_URL}/character?name=${search}`)
    .then((response) => {
      const character = response.data.data[0].attributes
      setCharacter(character);
    })
    .catch((error) => {
      updateError(error, "Character not found");
    });
  }

  const getStories = () => {
    axios.get(`${process.env.REACT_APP_API_URL}/character/${character.id}/stories`)
    .then((response) => {
      const stories = response.data.data;
      setStories(stories);
    })
    .catch((error) => {
      updateError(error, "Stories not found");
    });
  }

  const getStoryCharacters = (storyId) => {
    setStoryCharacters(null);
    axios.get(`${process.env.REACT_APP_API_URL}/story/${storyId}/characters`)
    .then((response) =>  {
      const storyCharacters = response.data.data;
      setStoryCharacters(storyCharacters);
    })
    .catch((error) =>  {
      updateError(error, "Characters not found for this story");
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
            <button type="button" onClick={getStories}>See stories</button>
          </div>
          <div class="panel stories-info">
            <h1>Stories</h1>
            <ul>
              {stories && stories.map((item, i) =>{
                  const {id, title, description} = item.attributes
                  return (
                    <li key={id}>
                      <button type="button" onClick={() => getStoryCharacters(id)}>{title}</button>
                      <div>{description}</div>
                      <br></br>
                    </li>
                  )
                })
              }
            </ul>
          </div>
          <div class="panel story-characters-info">
            <h1>Starring</h1>
            <ul>
              {storyCharacters && storyCharacters.map((item, i) =>{
                  const {id, name, thumbnail} = item.attributes
                  return (
                    <li key={id}>
                      <div class="character-info">
                        <h1>{name}</h1>
                        <img src= {thumbnail} />
                      </div>
                    </li>
                  )
                })
              }
            </ul>
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
