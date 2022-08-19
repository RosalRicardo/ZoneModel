using WriteVTK

length_x=100
length_y=100
length_z=100


field = zeros(length_x,length_y,length_z)

# apply boundary conditions
for x ∈ 1:length_x
    for y ∈ 1:length_y
      for z ∈ 1:length_z
        field[1,y,z] = 20
        field[100,y,z] = 20
        field[x,1,z] = 20
        field[x,100,z] = 20
        field[x,y,1] = 5
        field[x,y,100] = 20
      end
    end
end

# apply initial conditions
for i ∈ 35:55
    for j ∈ 35:55
        field[i,j,100] = 5
    end
end


# solve numerically
for x ∈ 2:length_x-1
    for y ∈ 2:length_y-1
        for z ∈ 2:length_z-1
            field[x,y,z] = 6*((field[x-1,y,z]+field[x,y-1,z]+field[x,y,z-1]+field[x+1,y,z]+field[x,y+1,z]+field[x,y,z+1]+9*field[x,y,z]+0.25)/20)
        end
    end
end

field


vtk_grid("temp5", length_x, length_y, length_z) do vtk
    vtk["temperature"] = field
end