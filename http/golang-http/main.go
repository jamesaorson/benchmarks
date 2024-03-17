// http server
package main

import (
	"fmt"
	"net/http"
)

func main() {
	handler := func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, "hello")
	}
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
