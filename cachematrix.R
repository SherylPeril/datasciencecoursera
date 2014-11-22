## 	makeCacheMatrix function creates a "matrix" object that can cache its inverse.  
## cacheSolve function computes the inverse of the makeCacheMatrix above. 


## makeCacheMatrix function

	
makeCacheMatrix <- function(x = matrix()) {  # input x will be a matrix
 
    m <- NULL    #  m will be our inverse matrix and it's reset to NULL every 
                 #    time makeCacheMatrix is called

                 #  note these next three functions are not run when makeCacheMatrix is called.
                 #   instead, they will be used by cacheSolve() to get values for x or for
                 #   m (inverse) and for setting the matrix.  These are usually called object 'methods'

    get <- function() { x }   # this function returns the value of the original matrix

    setinverse <- function(inverse)  { m <<- inverse}
                # this is called by cacheinverse() during the first cacheinverse()
                                #  access and it will store the value using superassignment
                                       
    getinverse <- function() { m } # this will return the cached value to cacheinverse() on
                                #  subsequent accesses

    list(get = get,                #  OK, this is accessed each time makeCacheMatrix() is called,       
         setinverse = setinverse,  #   that is, each time we make a new object.  This is a list of 
         getinverse = getinverse)  #   the internal functions ('methods') so a calling function
                                   #   knows how to access those methods.                            
}
      
      



## Return a matrix that is the inverse of 'x'

cacheSolve <- function(x, ...) {   # the input is an object created by makeCachMatrix
	m <- x$getinverse()               # accesses the object 'x' and gets the value of the inverse
	if(!is.null(m)) {              # if inverse was already cached (not NULL) ...  
		   message("getting cached data")  # ... send this message to the console
			return(m)                       # ... and return the inverse ... "return" ends 
                        			#   the function cacheSolve(), note

        }
    data <- x$get()        # we reach this code only if x$getinverse() returned NULL
    m <- solve(data, ...)   # if m was NULL then we have to calculate the inverse
    x$setinverse(m)           # store the calculated Inverse in x (see setinverse() in makeCacheMatrix
    m               # return the inverse to the code that called this function
}


