// Surface computes an SVG rendering of a 3-d surface function.
package main

import (
	"fmt"
	"io"
	"log"
	"math"
	"net/http"
)

const (
	width, height = 600, 320            // canvas size in pixels
	cells         = 100                 // number of grid cells
	xyrange       = 30                  // axis ranges (-xyranges..+xyranges)
	xyscale       = width / 2 / xyrange // pixels per x or y unit
	zscale        = height * 0.4        // pixels per z unit
	angle         = math.Pi / 6         // angle of x, y, axes (radians)
)

var sin30, cos30 = math.Sin(angle), math.Cos(angle)
var zmin, zmax = surfacerange()

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "image/svg+xml")
		makesvg(w)
	})
	log.Fatal(http.ListenAndServe("localhost:8000", nil))
}

func makesvg(out io.Writer) io.Writer {
	svg := fmt.Sprintf("<svg xmlns='http://www.w3.org/2000/svg' style='stroke: grey; fill: white; stroke-width: 0.7' width='%d' height='%d'>", width, height)
	for i := 0; i < cells; i++ {
		for j := 0; j < cells; j++ {
			ax, ay, az := corner(i+1, j)
			bx, by, bz := corner(i, j)
			cx, cy, cz := corner(i, j+1)
			dx, dy, dz := corner(i+1, j+1)
			color := colorise(az, bz, cz, dz)
			poly_points, ok := polyxml(ax, ay, bx, by, cx, cy, dx, dy, color)
			if ok {
				svg += poly_points
			}
		}
	}
	svg += "</svg>"
	out.Write([]byte(svg))
	return out
}

func corner(i, j int) (float64, float64, float64) {
	// Get (x, y, z)
	x, y, z := xyz(i, j)

	// Project (x, y, z) isometrically onto 2-D SVG canvas (sx, sy).
	sx := width/2 + (x-y)*cos30*xyscale
	sy := height/2 + (x+y)*sin30*xyscale - z*zscale
	return sx, sy, z
}

func xyz(i, j int) (float64, float64, float64) {
	// Find point (x, y) at corner of cell (i, j).
	x := xyrange * (float64(i)/cells - 0.5)
	y := xyrange * (float64(j)/cells - 0.5)

	// Compute surface height z.
	z := eggbox(x, y)

	return x, y, z
}

func surfacerange() (zmin, zmax float64) {
	min, max := math.Inf(1), math.Inf(-1)
	for i := 0; i < cells; i++ {
		for j := 0; j < cells; j++ {
			_, _, z := xyz(i, j)
			if z > max {
				max = z
			}
			if z < min {
				min = z
			}
		}
	}
	return min, max
}

func f(x, y float64) float64 {
	r := math.Hypot(x, y) // distance for (0, 0)
	return math.Sin(r) / r
}

func eggbox(x, y float64) float64 {
	a, b := 0.1, 1.5
	return a * (math.Sin(x/b) + math.Sin(y/b))
}

func saddle(x, y float64) float64 {
	return math.Pow(x, 2)/height - math.Pow(y, 2)/height
}

func polyxml(ax, ay, bx, by, cx, cy, dx, dy float64, color string) (value string, ok bool) {
	if anyNaN(ay, by, cy, dy) {
		return "", false
	}
	return fmt.Sprintf("<polygon points='%g,%g %g,%g %g,%g %g,%g' style='fill:%s'/>", ax, ay, bx, by, cx, cy, dx, dy, color), true
}

func anyNaN(xs ...float64) bool {
	for _, x := range xs {
		if math.IsNaN(x) {
			return true
		}
	}
	return false
}

func mean(xs ...float64) float64 {
	return sum(xs...) / float64(len(xs))
}

func sum(xs ...float64) float64 {
	sum := 0.0
	for _, x := range xs {
		sum += x
	}
	return sum
}

func colorise(xs ...float64) string {
	rr := (mean(xs...) - zmin) / (zmax - zmin) * math.MaxUint8
	bb := math.MaxUint8 - rr
	return fmt.Sprintf("#%02x00%02x", uint8(rr), uint8(bb))
}
