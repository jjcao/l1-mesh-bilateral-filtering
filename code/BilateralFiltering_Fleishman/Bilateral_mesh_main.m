function Bilateral_mesh_main(vertex,facets,meshName)

%Hui Wang, Nov,2, 2011

n = 5;
meanLength = meanEdgeLength(vertex, facets);
radius = meanLength * (1:5);

%Mean length based on SIGGRAPH paper
smoothScale = multiscaleBilateral(vertex, facets, radius);
for i = 1:n
    filename = strcat(meshName, '_Bilateral_meanLength_level', num2str(i), '.OFF');
    SaveOff(filename, smoothScale{i}, facets);
end

smoothScale_04_06 = multiscaleBilateral1(vertex, facets, radius, 0.4 * radius, 0.6 * radius);
for i = 1:n
    filename = strcat(meshName, '_Bilateral_04_06_level', num2str(i), '.OFF');
    SaveOff(filename, smoothScale_04_06{i}, facets);
end

smoothScale_04_03 = multiscaleBilateral1(vertex, facets, radius, 0.4 * radius, 0.3 * radius);
for i = 1:n
    filename = strcat(meshName, '_Bilateral_04_03_level', num2str(i), '.OFF');
    SaveOff(filename, smoothScale_04_03{i}, facets);
end

smoothScale_04_015 = multiscaleBilateral1(vertex, facets, radius, 0.4 * radius, 0.15 * radius);
for i = 1:n
    filename = strcat(meshName, '_Bilateral_04_015_level', num2str(i), '.OFF');
    SaveOff(filename, smoothScale_04_015{i}, facets);
end

smoothScale_04_01 = multiscaleBilateral1(vertex, facets, radius, 0.4 * radius, 0.1 * radius);
for i = 1:n
    filename = strcat(meshName, '_Bilateral_04_01_level', num2str(i), '.OFF');
    SaveOff(filename, smoothScale_04_01{i}, facets);
end

smoothScale_04_0075 = multiscaleBilateral1(vertex, facets, radius, 0.4 * radius, 0.075 * radius);
for i = 1:n
    filename = strcat(meshName, '_Bilateral_04_0075_level', num2str(i), '.OFF');
    SaveOff(filename, smoothScale_04_0075{i}, facets);
end

smoothScale_04_05 = multiscaleBilateral1(vertex, facets, radius, 0.4 * radius, 0.05 * radius);
for i = 1:n
    filename = strcat(meshName, '_Bilateral_04_005_level', num2str(i), '.OFF');
    SaveOff(filename, smoothScale_04_05{i}, facets);
end
%save