package main

import (
	"fmt"
	"io"
	"log"
	"math/rand"
	"net/http"
)

type ValueTracker struct {
	limit int
	last  int
}

func NewValueTracker(initial int, increment_limit int) *ValueTracker {
	return &ValueTracker{
		limit: increment_limit,
		last:  initial,
	}
}

func (v *ValueTracker) Next() int {
	inc := rand.Intn(v.limit)
    log.Println("unsigned inc: ", inc)
	switch sel := rand.Intn(2); sel {
	case 0:
		inc = -inc
	}
    log.Println("  signed inc: ", inc)
    log.Println(v)

	v.last = v.last + inc
	return v.last
}

func (v *ValueTracker) handler(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, fmt.Sprintf("%d", v.Next()))
}

func main() {
	vt := NewValueTracker(5, 10)
	http.HandleFunc("/", vt.handler)
	log.Fatal(http.ListenAndServe(":3333", nil))
}
