# TEST BACK

Create an API to register a new user with a pseudo in the payload

## Requirements  
* ruby 2.7.3  
* psql (PostgreSQL) 11.0  

## Setup
### Dependencies

```bash  
bundle install  
```  
### Database creation  
  
```bash  
bundle exec rake db:create  
bundle exec rake db:migrate  
```  

### Test
run rspec test for `integration`, `models`, `requests`, `routing`
```bash  
rspec
```  

### Run

```bash  
rails s -p 4000
```  

Test the API at http://localhost:4000/api-docs/index.html with Swagger UI

## API
There are two endpoints:

### `POST /api/v1/users`
Create new user with the pseudo in the payload

**payload**

```json
{
  "pseudo": "string"
}
```

### `GET /api/v1/users`
Retrieve all users in the database, we don't need to open database to check the result of the creation user.

## Architecture
- Swagger for the document and test API
- Rubocop for the code formatter
- Concerns
- Complexity `O(log(n))` with the binary search algorithm

### Solution for the research an available pseudo
This is the main problem of the test and It's so interesting.

There are many solutions for that, but the performance and the complexity are not the same.

#### 1. Store data

This is the first solution that I thought when I saw the test.

We will store all of the case of pseudo with three letters from A-Z in database, so we have to create `26^3 = 17567` lines.

Each pseudo in the table will be tagged with a boolean `available=true` by default. When a new user is created with a pseudo, the tag `available` of the pseudo will be set to `false`.

So, we can check if a pseudo is available or not and find a new available pseudo by using request SQL in this table.

This solution is not good, it creates too many volumes in the database and in the case pseudo has 4, 5 or 6... letter we have to insert too many lines.

#### 2. Basic loop

This is the basic solution, the complexity to find an available pseudo is `O(n^3)` 

```ruby
[A...Z].each do |first|
  [A...Z].each do |second|
    [A...Z].each do |third|
        find...
    end
  end
end
```
This solution is also not good

#### 3. Vector 3 dimensions

A pseudo can be like a vector in the dimension 3D `O(x,y,z)` with the value in `Ox`, `Oy`, `Oz` is `[A...Z]` instead of `1, 2 ,...]`.
![vector](./vendor/readme_img/vertor.png)  
Each pseudo is a vector, We can use the notion vector in Math to find the available pseudo like to find an available vector in the coordinates 3 dimensions.

Now, I don't have the solution for this idea, but for me it is an interesting idea and we can use it to find the pseudo near the pseudo exist.

#### 4. Binary search

This is the solution which is used in the test.

Each letter will be converted to a number and revert(letter <-> decimal). Example:

- A <-> 1
- B <-> 2
- Z <-> 26

So we can convert a pseudo to a number and revert. Example:

- `ABC = 1*(26^2) + 2*26 + 3 = 731` Function in project: `pseudo_to_decimal`
- `731 = 1*(26^2) + 2*26 + 3 => ABC` Function in project: `decimal_to_pseudo`

In the table `User` there are 2 attributes: `pseudo` and `decimal_index`. The value in `decimal_index` is the value of `pseudo` after converted.

To find the new available pseudo, we will find a new available `decimal_index` and convert the value founded to pseudo.

`AAA = 26^2 + 26 + 1 = 703` so the value minimum for `decimal_index` is 730

Now the problem becomes: **For an array number, find a number is not in the array (min_value = 0, max_vale = n)**

- Sort the array
- `array[index]` is always equal or greater than `index`
- If `array[index] = index` there is any available number in the array from `[0...index]`. Example: [0,1,2,3,4,6], from 0 to 4 there are any available number.
- If `array[index] > index` so there is at least an available number equal or less than `index`
- So if `array[index] = index` and `array[index +1] > index+1`, the value `index +1` is the available number that we found.
- With these conditions above, we can apply the idea of the [binary search algorithm](https://en.wikipedia.org/wiki/Binary_search_algorithm) in this problem.

-> Complexity: `O(log(n^3)` in the worst case.

![binary_search](./vendor/readme_img/binary_search.gif)