const getHeaders = new Headers({
  'X-Api-Key': process.env.API_KEY,
  'X-Key-Inflection': 'camel'
});

const postHeaders = new Headers({
  'X-Api-Key': process.env.API_KEY,
  'Content-Type': 'application/json',
  'X-Key-Inflection': 'camel'
})

export const apiGet = function(path) {
  const apiResponsePromise = new Promise((resolve, reject) => {
    try {
      fetch(path, { headers: getHeaders }).
        then(results => results.json()).
        then(data => {
          if (data.results !== undefined) {
            resolve(data.results)
          } else {
            resolve(data.data)
          }
        })
    } catch(error) { reject(error) };
  });
  return apiResponsePromise;
}

export const apiPost = function(path, body) {
  const apiResponsePromise = new Promise((resolve, reject) => {
    try {
      fetch(path, {
          headers: postHeaders,
          method: 'POST',
          body: JSON.stringify(body)
        }).then(response => resolve(response))
    } catch(error) { reject(error) };
  });
  return apiResponsePromise;
}
