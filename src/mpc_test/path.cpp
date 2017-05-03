#include <acado_optimal_control.hpp>

using namespace std;
USING_NAMESPACE_ACADO

double** readPathFile(ifstream& file, int path_length){

    /* Read file to array */
    double** path_data;
    path_data = new double*[path_length];
    for( int i = 0 ; i < path_length ; i++ ){
        path_data[i] = new double[2];
    }

    for( int row = 0 ; row < path_length ; ++row ){

        string line;
        getline(file, line);
        
        if( !file.good() ){
            cout << "readPathFile: Something went wrong when reading" \
                        " a line in the path file!\n";            
            break;
        }

        stringstream iss(line);

        string x_value;
 
        getline(iss, x_value, ',');
        if( !iss.good() ){
            cout << "readPathFile: Something went wrong when reading" \
                        " the x-value in the path file!\n";            
            break;
        }
        //cout << "X: " << x_value << "\n";
        
        stringstream x_convertor(x_value);
        x_convertor >> path_data[row][0];

        string y_value;
        getline(iss, y_value, '\n');
        /*if( !iss.good() ){
            cout << "readPathFile: Something went wrong when reading" \
                        " the y-value in the path file!\n";            
            break;
        }*/

        //cout << "y: " << y_value << "\n";

        stringstream y_convertor(y_value);
        y_convertor >> path_data[row][1];
    }
    
    return path_data;
}


int saveResults(double ** results, int length){
    ofstream file("./../results/results.m");
    if(file.is_open()){
        file << "STATES = [";
        for( int i = 0 ; i < length ; i++){
            file << results[i][0] << ", " << results[i][1] << ";\n";
        }
        file << "];\n";

        file << "CONTROLS = [";
        for( int i = 0 ; i < length ; i++){
            file << results[i][2] << ", " << results[i][3] << ";\n";
        }
        file << "];\n";

        /*file << "PATH = [";
        for( int i = 0 ; i < path_length ; i++){
            file << path[i][2] << ", " << path[i][3] << ";\n";
        }
        file << "];\n";*/
        cout << "Saving results to file.\n";
        return 0;
    }else{
        cout << "saveResults: Could not create file!\n";
       return 1;
    }
}


VariablesGrid generateHorizon(double** path_data, double timestep,
                              int horizon_length, int path_length,
                              double x_start,  double y_start,
                              double dx_start, double dy_start){

    /* Initalize storage */
    int no_timesteps = horizon_length/timestep;
    VariablesGrid path(2, 0, horizon_length, no_timesteps+1);

    DVector points(2);


    /* Initialize variables */
    double  x =  x_start;
    double  y =  y_start;
    double dx = dx_start;
    double dy = dy_start;

    double speed = 35.0;
    double distance = speed*timestep;      // [m]

    points(0) = x;
    points(1) = y;
    path.setVector(0, points);

    int point_found = 0;

    /* Generate path */
    for( int step = 0 ; step < no_timesteps ; step++ ){
        for( int i = path_length-1 ; i >= 0 ; --i ){            
            double x_dist = path_data[i][0] - x;
            double y_dist = path_data[i][1] - y;
            double radius = sqrt(x_dist*x_dist + y_dist*y_dist);
            //cout << "Radius: " << radius << "\n";
            if( (radius > distance-0.08) && (radius < distance+0.08)){
                x = path_data[i][0];
                y = path_data[i][1];
                //cout << "Found point!: " << radius << "\n";
                points(0) = path_data[i][0];
                points(1) = path_data[i][1];
                path.setVector(step+1, points);
                point_found = 1;
                break;
            }
        }
        if(!point_found){
            cout << "Could not find a point!\n";
            throw 1;
        }
    }
    return path;
}
