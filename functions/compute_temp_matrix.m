function[matrix] = compute_temp_matrix(matrix, cell) 
    % updating the temporary matrix of each recursive call with the selected cell
    % the position of the cell is marked as -1 in the matrix
    matrix(cell(1), cell(2)) = -1;
end