# Filtering and smoothing in left invertible systems
The repo contains Matlab code for filtering and smoothing in left invertible, finite dimensional, linear systems. In particular, it includes the code for: 
1. The required rank decompositions which are implemented here using SVD,
2. The matrix definitions required before the time recursions,
3. The forwards and backwards time recursions.

The algorithm is implemented for a simple mechanical system with two masses, a spring and a damper driven by two forces. 

## Installation
1. Clone or download this repository.
2. Open the Matlab files in your environment.
3. Run the main.m file.

## Usage
1. Change the system in Model.m (from changes to the parameter values and sensor selection to a completely different system).
2. Change the filter initialisation x0, P0 in main.m and run it. 
3. Review console outputs and result plots.

## Contributing
Feel free to submit issues or pull requests to improve the code.
