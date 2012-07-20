package model 
{
	/**
	 * ...
	 * @author Anlei
	 */
	public class daeData
	{
		
		public var YIZ:XML = <COLLADA xmlns="http://www.collada.org/2005/11/COLLADASchema" version="1.4.1">
  <asset>
    <contributor>
      <author>Administrator</author>
      <authoring_tool>3dsMax 8 - Feeling ColladaMax v3.05B.</authoring_tool>
      <comments>ColladaMax Export Options: ExportNormals=1;ExportEPolyAsTriangles=1;ExportXRefs=1;ExportSelected=0;ExportTangents=0;ExportAnimations=1;SampleAnim=0;ExportAnimClip=0;BakeMatrices=0;ExportRelativePaths=1;AnimStart=0;AnimEnd=3.33333;</comments>
      <source_data>file:///E:/Save/desktop.max</source_data>
    </contributor>
    <created>2009-11-27T02:07:15Z</created>
    <modified>2009-11-27T02:07:16Z</modified>
    <unit meter="0.0254" name="inch"/>
    <up_axis>Z_UP</up_axis>
  </asset>
  <library_materials>
    <material id="skin_01" name="skin_01">
      <instance_effect url="#skin_01-fx"/>
      <extra>
        <technique profile="FCOLLADA">
          <dynamic_attributes>
            <DirectX_______ sid="DirectX_______">
              <enabled type="bool">0</enabled>
              <effect type="int">0</effect>
              <dxStdMat type="bool">0</dxStdMat>
            </DirectX_______>
          </dynamic_attributes>
        </technique>
      </extra>
    </material>
    <material id="skin_02" name="skin_02">
      <instance_effect url="#skin_02-fx"/>
      <extra>
        <technique profile="FCOLLADA">
          <dynamic_attributes>
            <DirectX_______ sid="DirectX_______">
              <enabled type="bool">0</enabled>
              <effect type="int">0</effect>
              <dxStdMat type="bool">0</dxStdMat>
            </DirectX_______>
          </dynamic_attributes>
        </technique>
      </extra>
    </material>
  </library_materials>
  <library_effects>
    <effect id="skin_01-fx" name="skin_01">
      <profile_COMMON>
        <technique sid="common">
          <blinn>
            <ambient>
              <color>1 0.588235 0.588235 1</color>
            </ambient>
            <diffuse>
              <color>1 0.588235 0.588235 1</color>
            </diffuse>
            <specular>
              <color>0.9 0.9 0.9 1</color>
            </specular>
            <shininess>
              <float>0.1</float>
            </shininess>
            <reflective>
              <color>0 0 0 1</color>
            </reflective>
            <reflectivity>
              <float>1</float>
            </reflectivity>
            <transparent opaque="A_ONE">
              <color>1 1 1 1</color>
            </transparent>
            <transparency>
              <float>1</float>
            </transparency>
          </blinn>
          <extra>
            <technique profile="FCOLLADA">
              <spec_level>
                <float>0</float>
              </spec_level>
              <emission_level>
                <float>0</float>
              </emission_level>
            </technique>
          </extra>
        </technique>
      </profile_COMMON>
      <extra>
        <technique profile="MAX3D">
          <faceted>0</faceted>
          <double_sided>0</double_sided>
          <wireframe>0</wireframe>
          <face_map>0</face_map>
        </technique>
      </extra>
    </effect>
    <effect id="skin_02-fx" name="skin_02">
      <profile_COMMON>
        <technique sid="common">
          <blinn>
            <ambient>
              <color>0 1 0.047058 1</color>
            </ambient>
            <diffuse>
              <color>0 1 0.047058 1</color>
            </diffuse>
            <specular>
              <color>0.9 0.9 0.9 1</color>
            </specular>
            <shininess>
              <float>0.1</float>
            </shininess>
            <reflective>
              <color>0 0 0 1</color>
            </reflective>
            <reflectivity>
              <float>1</float>
            </reflectivity>
            <transparent opaque="A_ONE">
              <color>1 1 1 1</color>
            </transparent>
            <transparency>
              <float>1</float>
            </transparency>
          </blinn>
          <extra>
            <technique profile="FCOLLADA">
              <spec_level>
                <float>0</float>
              </spec_level>
              <emission_level>
                <float>0</float>
              </emission_level>
            </technique>
          </extra>
        </technique>
      </profile_COMMON>
      <extra>
        <technique profile="MAX3D">
          <faceted>0</faceted>
          <double_sided>0</double_sided>
          <wireframe>0</wireframe>
          <face_map>0</face_map>
        </technique>
      </extra>
    </effect>
  </library_effects>
  <library_geometries>
    <geometry id="Box01-mesh" name="Box01">
      <mesh>
        <source id="Box01-mesh-positions">
          <float_array id="Box01-mesh-positions-array" count="120">-10 -10 0 10 -10 0 -10 10 0 10 10 0 -10 -10 1 10 -10 1 -10 10 1 10 10 1 7.72211 7.82656 -8.07616 9.51889 7.82656 -8.07616 7.72211 9.53777 -8.07616 9.51889 9.53777 -8.07616 7.72211 7.82656 0.052124 9.51889 7.82656 0.052124 7.72211 9.53777 0.052124 9.51889 9.53777 0.052124 7.72211 -9.55712 -8.07616 9.51889 -9.55712 -8.07616 7.72211 -7.8459 -8.07616 9.51889 -7.8459 -8.07616 7.72211 -9.55712 0.052124 9.51889 -9.55712 0.052124 7.72211 -7.8459 0.052124 9.51889 -7.8459 0.052124 -9.39902 7.82656 -8.07616 -7.60224 7.82656 -8.07616 -9.39902 9.53777 -8.07616 -7.60224 9.53777 -8.07616 -9.39902 7.82656 0.052124 -7.60224 7.82656 0.052124 -9.39902 9.53777 0.052124 -7.60224 9.53777 0.052124 -9.39902 -9.55712 -8.07616 -7.60224 -9.55712 -8.07616 -9.39902 -7.8459 -8.07616 -7.60224 -7.8459 -8.07616 -9.39902 -9.55712 0.052124 -7.60224 -9.55712 0.052124 -9.39902 -7.8459 0.052124 -7.60224 -7.8459 0.052124</float_array>
          <technique_common>
            <accessor source="#Box01-mesh-positions-array" count="40" stride="3">
              <param name="X" type="float"/>
              <param name="Y" type="float"/>
              <param name="Z" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <source id="Box01-mesh-normals">
          <float_array id="Box01-mesh-normals-array" count="360">0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0</float_array>
          <technique_common>
            <accessor source="#Box01-mesh-normals-array" count="120" stride="3">
              <param name="X" type="float"/>
              <param name="Y" type="float"/>
              <param name="Z" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <source id="Box01-mesh-map-channel1">
          <float_array id="Box01-mesh-map-channel1-array" count="360">1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0</float_array>
          <technique_common>
            <accessor source="#Box01-mesh-map-channel1-array" count="120" stride="3">
              <param name="S" type="float"/>
              <param name="T" type="float"/>
              <param name="P" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <vertices id="Box01-mesh-vertices">
          <input semantic="POSITION" source="#Box01-mesh-positions"/>
        </vertices>
        <triangles material="skin_01" count="60">
          <input semantic="VERTEX" source="#Box01-mesh-vertices" offset="0"/>
          <input semantic="NORMAL" source="#Box01-mesh-normals" offset="1"/>
          <input semantic="TEXCOORD" source="#Box01-mesh-map-channel1" offset="2" set="1"/>
          <p>0 0 0 2 1 2 3 2 3 3 2 3 1 3 1 0 0 0 4 4 4 5 5 5 7 6 7 7 6 7 6 7 6 4 4 4 0 8 8 1 9 9 5 10 11 5 10 11 4 11 10 0 8 8 1 12 12 3 13 13 7 14 15 7 14 15 5 15 14 1 12 12 3 16 16 2 17 17 6 18 19 6 18 19 7 19 18 3 16 16 2 20 20 0 21 21 4 22 23 4 22 23 6 23 22 2 20 20 8 24 24 10 25 26 11 26 27 11 26 27 9 27 25 8 24 24 12 28 28 13 29 29 15 30 31 15 30 31 14 31 30 12 28 28 8 32 32 9 33 33 13 34 35 13 34 35 12 35 34 8 32 32 9 36 36 11 37 37 15 38 39 15 38 39 13 39 38 9 36 36 11 40 40 10 41 41 14 42 43 14 42 43 15 43 42 11 40 40 10 44 44 8 45 45 12 46 47 12 46 47 14 47 46 10 44 44 16 48 48 18 49 50 19 50 51 19 50 51 17 51 49 16 48 48 20 52 52 21 53 53 23 54 55 23 54 55 22 55 54 20 52 52 16 56 56 17 57 57 21 58 59 21 58 59 20 59 58 16 56 56 17 60 60 19 61 61 23 62 63 23 62 63 21 63 62 17 60 60 19 64 64 18 65 65 22 66 67 22 66 67 23 67 66 19 64 64 18 68 68 16 69 69 20 70 71 20 70 71 22 71 70 18 68 68 24 72 72 26 73 74 27 74 75 27 74 75 25 75 73 24 72 72 28 76 76 29 77 77 31 78 79 31 78 79 30 79 78 28 76 76 24 80 80 25 81 81 29 82 83 29 82 83 28 83 82 24 80 80 25 84 84 27 85 85 31 86 87 31 86 87 29 87 86 25 84 84 27 88 88 26 89 89 30 90 91 30 90 91 31 91 90 27 88 88 26 92 92 24 93 93 28 94 95 28 94 95 30 95 94 26 92 92 32 96 96 34 97 98 35 98 99 35 98 99 33 99 97 32 96 96 36 100 100 37 101 101 39 102 103 39 102 103 38 103 102 36 100 100 32 104 104 33 105 105 37 106 107 37 106 107 36 107 106 32 104 104 33 108 108 35 109 109 39 110 111 39 110 111 37 111 110 33 108 108 35 112 112 34 113 113 38 114 115 38 114 115 39 115 114 35 112 112 34 116 116 32 117 117 36 118 119 36 118 119 38 119 118 34 116 116</p>
        </triangles>
      </mesh>
    </geometry>
    <geometry id="Box03-mesh" name="Box03">
      <mesh>
        <source id="Box03-mesh-positions">
          <float_array id="Box03-mesh-positions-array" count="216">-4.51909 -6 0 -1.50636 -6 0 1.50636 -6 0 4.51909 -6 0 -4.51909 -4.63724 0.000000 -1.77383 -4.63724 0.000000 1.77383 -4.63724 0.000000 4.51909 -4.63724 0.000000 -5.69264 1.08013 -0.000000 -2.23447 1.08013 -0.000000 2.23447 1.08013 -0.000000 5.69264 1.08013 -0.000000 -6 2.4429 0 -2.35512 2.4429 0 2.35512 2.4429 0 6 2.4429 0 -4.51909 -6 1 -1.50636 -6 1 1.50636 -6 1 4.51909 -6 1 -4.51909 -4.63724 1 -1.77383 -4.63724 1 1.77383 -4.63724 1 4.51909 -4.63724 1 -5.69264 1.08013 1 -2.23447 1.08013 1 2.23447 1.08013 1 5.69264 1.08013 1 -6 2.4429 1 -2.35512 2.4429 1 2.35512 2.4429 1 6 2.4429 1 -4.73854 -6.89895 0.955893 4.73854 -6.89895 0.955893 -6 -6.89895 -11.0441 6 -6.89895 -11.0441 -4.73854 -5.89895 0.955893 4.73854 -5.89895 0.955893 -6 -5.89895 -11.0441 6 -5.89895 -11.0441 3.81943 -10.9174 -8.79144 5.19889 -10.9174 -8.79144 3.81943 -10.9174 -10.1709 5.19889 -10.9174 -10.1709 3.81943 -6.9174 -8.79144 5.19889 -6.9174 -8.79144 3.81943 -6.9174 -10.1709 5.19889 -6.9174 -10.1709 3.59564 -10.9174 -0.912474 4.9751 -10.9174 -0.912474 3.59564 -10.9174 -2.29194 4.9751 -10.9174 -2.29194 3.59564 -6.9174 -0.912474 4.9751 -6.9174 -0.912474 3.59564 -6.9174 -2.29194 4.9751 -6.9174 -2.29194 -5.06505 -10.9174 -8.79144 -3.68559 -10.9174 -8.79144 -5.06505 -10.9174 -10.1709 -3.68559 -10.9174 -10.1709 -5.06505 -6.9174 -8.79144 -3.68559 -6.9174 -8.79144 -5.06505 -6.9174 -10.1709 -3.68559 -6.9174 -10.1709 -4.84079 -10.9174 -0.912474 -3.46133 -10.9174 -0.912474 -4.84079 -10.9174 -2.29194 -3.46133 -10.9174 -2.29194 -4.84079 -6.9174 -0.912474 -3.46133 -6.9174 -0.912474 -4.84079 -6.9174 -2.29194 -3.46133 -6.9174 -2.29194</float_array>
          <technique_common>
            <accessor source="#Box03-mesh-positions-array" count="72" stride="3">
              <param name="X" type="float"/>
              <param name="Y" type="float"/>
              <param name="Z" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <source id="Box03-mesh-normals">
          <float_array id="Box03-mesh-normals-array" count="624">0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 0.994881 -0.101051 0 0.994881 -0.101051 0 1 0 0 0.977582 -0.210553 0 0.977582 -0.210553 0 0.975496 -0.220018 0 0.975496 -0.220018 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 -0.975496 -0.220018 0 -0.977582 -0.210553 0 -0.977582 -0.210553 0 -0.975496 -0.220018 0 -0.994881 -0.101051 0 -0.994881 -0.101051 0 -1 0 0 -1 0 0 -0.99677 0.080308 0 -0.99677 0.080308 0 -0.99677 0.080308 0 -0.99677 0.080308 0 -0.99677 0.080308 0 -0.99677 0.080308 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0.99677 0.080308 0 0.99677 0.080308 0 0.99677 0.080308 0 0.99677 0.080308 0 0.99677 0.080308 0 0.99677 0.080308 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0.99452 0 0.104546 0.99452 0 0.104546 0.99452 0 0.104546 0.99452 0 0.104546 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -0.99452 0 0.104546 -0.99452 0 0.104546 -0.99452 0 0.104546 -0.99452 0 0.104546 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -1 0 0 -1 0 0 -1 0 0 -1 0 0</float_array>
          <technique_common>
            <accessor source="#Box03-mesh-normals-array" count="208" stride="3">
              <param name="X" type="float"/>
              <param name="Y" type="float"/>
              <param name="Z" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <source id="Box03-mesh-map-channel1">
          <float_array id="Box03-mesh-map-channel1-array" count="552">1 0 0 0.666667 0 0 0.333333 0 0 0 0 0 1 0.333333 0 0.666667 0.333333 0 0.333333 0.333333 0 0 0.333333 0 1 0.666667 0 0.666667 0.666667 0 0.333333 0.666667 0 0 0.666667 0 1 1 0 0.666667 1 0 0.333333 1 0 0 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 0.333333 0 0.333333 0.333333 0 0.666667 0.333333 0 1 0.333333 0 0 0.666667 0 0.333333 0.666667 0 0.666667 0.666667 0 1 0.666667 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0</float_array>
          <technique_common>
            <accessor source="#Box03-mesh-map-channel1-array" count="184" stride="3">
              <param name="S" type="float"/>
              <param name="T" type="float"/>
              <param name="P" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <vertices id="Box03-mesh-vertices">
          <input semantic="POSITION" source="#Box03-mesh-positions"/>
        </vertices>
        <triangles material="skin_02" count="124">
          <input semantic="VERTEX" source="#Box03-mesh-vertices" offset="0"/>
          <input semantic="NORMAL" source="#Box03-mesh-normals" offset="1"/>
          <input semantic="TEXCOORD" source="#Box03-mesh-map-channel1" offset="2" set="1"/>
          <p>0 0 0 4 1 4 5 2 5 5 2 5 1 3 1 0 0 0 1 3 1 5 2 5 6 4 6 6 4 6 2 5 2 1 3 1 2 5 2 6 4 6 7 6 7 7 6 7 3 7 3 2 5 2 4 1 4 8 8 8 9 9 9 9 9 9 5 2 5 4 1 4 6 4 6 10 10 10 11 11 11 11 11 11 7 6 7 6 4 6 8 8 8 12 12 12 13 13 13 13 13 13 9 9 9 8 8 8 9 9 9 13 13 13 14 14 14 14 14 14 10 10 10 9 9 9 10 10 10 14 14 14 15 15 15 15 15 15 11 11 11 10 10 10 16 16 16 17 17 17 21 18 21 21 18 21 20 19 20 16 16 16 17 17 17 18 20 18 22 21 22 22 21 22 21 18 21 17 17 17 18 20 18 19 22 19 23 23 23 23 23 23 22 21 22 18 20 18 20 19 20 21 18 21 25 24 25 25 24 25 24 25 24 20 19 20 22 21 22 23 23 23 27 26 27 27 26 27 26 27 26 22 21 22 24 25 24 25 24 25 29 28 29 29 28 29 28 29 28 24 25 24 25 24 25 26 27 26 30 30 30 30 30 30 29 28 29 25 24 25 26 27 26 27 26 27 31 31 31 31 31 31 30 30 30 26 27 26 0 32 32 1 33 33 17 34 37 17 34 37 16 35 36 0 32 32 1 33 33 2 36 34 18 37 38 18 37 38 17 34 37 1 33 33 2 36 34 3 38 35 19 39 39 19 39 39 18 37 38 2 36 34 3 40 40 7 41 41 23 42 45 23 42 45 19 43 44 3 40 40 7 41 41 11 44 42 27 45 46 27 45 46 23 42 45 7 41 41 11 44 42 15 46 43 31 47 47 31 47 47 27 45 46 11 44 42 15 48 48 14 49 49 30 50 53 30 50 53 31 51 52 15 48 48 14 49 49 13 52 50 29 53 54 29 53 54 30 50 53 14 49 49 13 52 50 12 54 51 28 55 55 28 55 55 29 53 54 13 52 50 12 56 56 8 57 57 24 58 61 24 58 61 28 59 60 12 56 56 8 57 57 4 60 58 20 61 62 20 61 62 24 58 61 8 57 57 4 60 58 0 62 59 16 63 63 16 63 63 20 61 62 4 60 58 10 64 10 6 65 6 22 66 22 22 67 22 26 68 26 10 69 10 6 70 6 5 71 5 21 72 21 21 73 21 22 74 22 6 75 6 25 76 25 21 77 21 5 78 5 5 79 5 9 80 9 25 81 25 9 82 9 10 83 10 26 84 26 26 85 26 25 86 25 9 87 9 32 88 64 34 89 66 35 90 67 35 90 67 33 91 65 32 88 64 36 92 68 37 93 69 39 94 71 39 94 71 38 95 70 36 92 68 32 96 72 33 97 73 37 98 75 37 98 75 36 99 74 32 96 72 33 100 76 35 101 77 39 102 79 39 102 79 37 103 78 33 100 76 35 104 80 34 105 81 38 106 83 38 106 83 39 107 82 35 104 80 34 108 84 32 109 85 36 110 87 36 110 87 38 111 86 34 108 84 40 112 88 42 113 90 43 114 91 43 114 91 41 115 89 40 112 88 44 116 92 45 117 93 47 118 95 47 118 95 46 119 94 44 116 92 40 120 96 41 121 97 45 122 99 45 122 99 44 123 98 40 120 96 41 124 100 43 125 101 47 126 103 47 126 103 45 127 102 41 124 100 43 128 104 42 129 105 46 130 107 46 130 107 47 131 106 43 128 104 42 132 108 40 133 109 44 134 111 44 134 111 46 135 110 42 132 108 48 136 112 50 137 114 51 138 115 51 138 115 49 139 113 48 136 112 52 140 116 53 141 117 55 142 119 55 142 119 54 143 118 52 140 116 48 144 120 49 145 121 53 146 123 53 146 123 52 147 122 48 144 120 49 148 124 51 149 125 55 150 127 55 150 127 53 151 126 49 148 124 51 152 128 50 153 129 54 154 131 54 154 131 55 155 130 51 152 128 50 156 132 48 157 133 52 158 135 52 158 135 54 159 134 50 156 132 56 160 136 58 161 138 59 162 139 59 162 139 57 163 137 56 160 136 60 164 140 61 165 141 63 166 143 63 166 143 62 167 142 60 164 140 56 168 144 57 169 145 61 170 147 61 170 147 60 171 146 56 168 144 57 172 148 59 173 149 63 174 151 63 174 151 61 175 150 57 172 148 59 176 152 58 177 153 62 178 155 62 178 155 63 179 154 59 176 152 58 180 156 56 181 157 60 182 159 60 182 159 62 183 158 58 180 156 64 184 160 66 185 162 67 186 163 67 186 163 65 187 161 64 184 160 68 188 164 69 189 165 71 190 167 71 190 167 70 191 166 68 188 164 64 192 168 65 193 169 69 194 171 69 194 171 68 195 170 64 192 168 65 196 172 67 197 173 71 198 175 71 198 175 69 199 174 65 196 172 67 200 176 66 201 177 70 202 179 70 202 179 71 203 178 67 200 176 66 204 180 64 205 181 68 206 183 68 206 183 70 207 182 66 204 180</p>
        </triangles>
      </mesh>
    </geometry>
  </library_geometries>
  <library_visual_scenes>
    <visual_scene id="desktop.max" name="desktop_max">
      <node id="Box01-node" name="Box01" type="NODE">
        <translate>1.3224 1.57203 9.65622</translate>
        <instance_geometry url="#Box01-mesh">
          <bind_material>
            <technique_common>
              <instance_material symbol="skin_01" target="#skin_01"/>
            </technique_common>
          </bind_material>
        </instance_geometry>
      </node>
      <node id="Box03-node" name="Box03" type="NODE">
        <translate>24.8844 -4.13575 10.9773</translate>
        <rotate>-1 0 0 -90</rotate>
        <instance_geometry url="#Box03-mesh">
          <bind_material>
            <technique_common>
              <instance_material symbol="skin_02" target="#skin_02"/>
            </technique_common>
          </bind_material>
        </instance_geometry>
      </node>
      <extra>
        <technique profile="FCOLLADA">
          <start_time>0</start_time>
          <end_time>3.33333</end_time>
        </technique>
      </extra>
      <extra>
        <technique profile="MAX3D">
          <frame_rate>30</frame_rate>
        </technique>
      </extra>
    </visual_scene>
  </library_visual_scenes>
  <scene>
    <instance_visual_scene url="#desktop.max"/>
  </scene>
</COLLADA>;

		public var DESK:XML = <COLLADA xmlns="http://www.collada.org/2005/11/COLLADASchema" version="1.4.1">
  <asset>
    <contributor>
      <author>Administrator</author>
      <authoring_tool>3dsMax 8 - Feeling ColladaMax v3.05B.</authoring_tool>
      <comments>ColladaMax Export Options: ExportNormals=1;ExportEPolyAsTriangles=1;ExportXRefs=1;ExportSelected=0;ExportTangents=0;ExportAnimations=1;SampleAnim=0;ExportAnimClip=0;BakeMatrices=0;ExportRelativePaths=1;AnimStart=0;AnimEnd=3.33333;</comments>
      <source_data>file:///E:/Save/desktop.max</source_data>
    </contributor>
    <created>2009-11-27T02:07:00Z</created>
    <modified>2009-11-27T02:07:00Z</modified>
    <unit meter="0.0254" name="inch"/>
    <up_axis>Z_UP</up_axis>
  </asset>
  <library_materials>
    <material id="skin_01" name="skin_01">
      <instance_effect url="#skin_01-fx"/>
      <extra>
        <technique profile="FCOLLADA">
          <dynamic_attributes>
            <DirectX_______ sid="DirectX_______">
              <enabled type="bool">0</enabled>
              <effect type="int">0</effect>
              <dxStdMat type="bool">0</dxStdMat>
            </DirectX_______>
          </dynamic_attributes>
        </technique>
      </extra>
    </material>
    <material id="skin_02" name="skin_02">
      <instance_effect url="#skin_02-fx"/>
      <extra>
        <technique profile="FCOLLADA">
          <dynamic_attributes>
            <DirectX_______ sid="DirectX_______">
              <enabled type="bool">0</enabled>
              <effect type="int">0</effect>
              <dxStdMat type="bool">0</dxStdMat>
            </DirectX_______>
          </dynamic_attributes>
        </technique>
      </extra>
    </material>
  </library_materials>
  <library_effects>
    <effect id="skin_01-fx" name="skin_01">
      <profile_COMMON>
        <technique sid="common">
          <blinn>
            <ambient>
              <color>1 0.588235 0.588235 1</color>
            </ambient>
            <diffuse>
              <color>1 0.588235 0.588235 1</color>
            </diffuse>
            <specular>
              <color>0.9 0.9 0.9 1</color>
            </specular>
            <shininess>
              <float>0.1</float>
            </shininess>
            <reflective>
              <color>0 0 0 1</color>
            </reflective>
            <reflectivity>
              <float>1</float>
            </reflectivity>
            <transparent opaque="A_ONE">
              <color>1 1 1 1</color>
            </transparent>
            <transparency>
              <float>1</float>
            </transparency>
          </blinn>
          <extra>
            <technique profile="FCOLLADA">
              <spec_level>
                <float>0</float>
              </spec_level>
              <emission_level>
                <float>0</float>
              </emission_level>
            </technique>
          </extra>
        </technique>
      </profile_COMMON>
      <extra>
        <technique profile="MAX3D">
          <faceted>0</faceted>
          <double_sided>0</double_sided>
          <wireframe>0</wireframe>
          <face_map>0</face_map>
        </technique>
      </extra>
    </effect>
    <effect id="skin_02-fx" name="skin_02">
      <profile_COMMON>
        <technique sid="common">
          <blinn>
            <ambient>
              <color>0 1 0.047058 1</color>
            </ambient>
            <diffuse>
              <color>0 1 0.047058 1</color>
            </diffuse>
            <specular>
              <color>0.9 0.9 0.9 1</color>
            </specular>
            <shininess>
              <float>0.1</float>
            </shininess>
            <reflective>
              <color>0 0 0 1</color>
            </reflective>
            <reflectivity>
              <float>1</float>
            </reflectivity>
            <transparent opaque="A_ONE">
              <color>1 1 1 1</color>
            </transparent>
            <transparency>
              <float>1</float>
            </transparency>
          </blinn>
          <extra>
            <technique profile="FCOLLADA">
              <spec_level>
                <float>0</float>
              </spec_level>
              <emission_level>
                <float>0</float>
              </emission_level>
            </technique>
          </extra>
        </technique>
      </profile_COMMON>
      <extra>
        <technique profile="MAX3D">
          <faceted>0</faceted>
          <double_sided>0</double_sided>
          <wireframe>0</wireframe>
          <face_map>0</face_map>
        </technique>
      </extra>
    </effect>
  </library_effects>
  <library_geometries>
    <geometry id="Box01-mesh" name="Box01">
      <mesh>
        <source id="Box01-mesh-positions">
          <float_array id="Box01-mesh-positions-array" count="120">-10 -10 0 10 -10 0 -10 10 0 10 10 0 -10 -10 1 10 -10 1 -10 10 1 10 10 1 7.72211 7.82656 -8.07616 9.51889 7.82656 -8.07616 7.72211 9.53777 -8.07616 9.51889 9.53777 -8.07616 7.72211 7.82656 0.052124 9.51889 7.82656 0.052124 7.72211 9.53777 0.052124 9.51889 9.53777 0.052124 7.72211 -9.55712 -8.07616 9.51889 -9.55712 -8.07616 7.72211 -7.8459 -8.07616 9.51889 -7.8459 -8.07616 7.72211 -9.55712 0.052124 9.51889 -9.55712 0.052124 7.72211 -7.8459 0.052124 9.51889 -7.8459 0.052124 -9.39902 7.82656 -8.07616 -7.60224 7.82656 -8.07616 -9.39902 9.53777 -8.07616 -7.60224 9.53777 -8.07616 -9.39902 7.82656 0.052124 -7.60224 7.82656 0.052124 -9.39902 9.53777 0.052124 -7.60224 9.53777 0.052124 -9.39902 -9.55712 -8.07616 -7.60224 -9.55712 -8.07616 -9.39902 -7.8459 -8.07616 -7.60224 -7.8459 -8.07616 -9.39902 -9.55712 0.052124 -7.60224 -9.55712 0.052124 -9.39902 -7.8459 0.052124 -7.60224 -7.8459 0.052124</float_array>
          <technique_common>
            <accessor source="#Box01-mesh-positions-array" count="40" stride="3">
              <param name="X" type="float"/>
              <param name="Y" type="float"/>
              <param name="Z" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <source id="Box01-mesh-normals">
          <float_array id="Box01-mesh-normals-array" count="360">0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0</float_array>
          <technique_common>
            <accessor source="#Box01-mesh-normals-array" count="120" stride="3">
              <param name="X" type="float"/>
              <param name="Y" type="float"/>
              <param name="Z" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <source id="Box01-mesh-map-channel1">
          <float_array id="Box01-mesh-map-channel1-array" count="360">1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0</float_array>
          <technique_common>
            <accessor source="#Box01-mesh-map-channel1-array" count="120" stride="3">
              <param name="S" type="float"/>
              <param name="T" type="float"/>
              <param name="P" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <vertices id="Box01-mesh-vertices">
          <input semantic="POSITION" source="#Box01-mesh-positions"/>
        </vertices>
        <triangles material="skin_01" count="60">
          <input semantic="VERTEX" source="#Box01-mesh-vertices" offset="0"/>
          <input semantic="NORMAL" source="#Box01-mesh-normals" offset="1"/>
          <input semantic="TEXCOORD" source="#Box01-mesh-map-channel1" offset="2" set="1"/>
          <p>0 0 0 2 1 2 3 2 3 3 2 3 1 3 1 0 0 0 4 4 4 5 5 5 7 6 7 7 6 7 6 7 6 4 4 4 0 8 8 1 9 9 5 10 11 5 10 11 4 11 10 0 8 8 1 12 12 3 13 13 7 14 15 7 14 15 5 15 14 1 12 12 3 16 16 2 17 17 6 18 19 6 18 19 7 19 18 3 16 16 2 20 20 0 21 21 4 22 23 4 22 23 6 23 22 2 20 20 8 24 24 10 25 26 11 26 27 11 26 27 9 27 25 8 24 24 12 28 28 13 29 29 15 30 31 15 30 31 14 31 30 12 28 28 8 32 32 9 33 33 13 34 35 13 34 35 12 35 34 8 32 32 9 36 36 11 37 37 15 38 39 15 38 39 13 39 38 9 36 36 11 40 40 10 41 41 14 42 43 14 42 43 15 43 42 11 40 40 10 44 44 8 45 45 12 46 47 12 46 47 14 47 46 10 44 44 16 48 48 18 49 50 19 50 51 19 50 51 17 51 49 16 48 48 20 52 52 21 53 53 23 54 55 23 54 55 22 55 54 20 52 52 16 56 56 17 57 57 21 58 59 21 58 59 20 59 58 16 56 56 17 60 60 19 61 61 23 62 63 23 62 63 21 63 62 17 60 60 19 64 64 18 65 65 22 66 67 22 66 67 23 67 66 19 64 64 18 68 68 16 69 69 20 70 71 20 70 71 22 71 70 18 68 68 24 72 72 26 73 74 27 74 75 27 74 75 25 75 73 24 72 72 28 76 76 29 77 77 31 78 79 31 78 79 30 79 78 28 76 76 24 80 80 25 81 81 29 82 83 29 82 83 28 83 82 24 80 80 25 84 84 27 85 85 31 86 87 31 86 87 29 87 86 25 84 84 27 88 88 26 89 89 30 90 91 30 90 91 31 91 90 27 88 88 26 92 92 24 93 93 28 94 95 28 94 95 30 95 94 26 92 92 32 96 96 34 97 98 35 98 99 35 98 99 33 99 97 32 96 96 36 100 100 37 101 101 39 102 103 39 102 103 38 103 102 36 100 100 32 104 104 33 105 105 37 106 107 37 106 107 36 107 106 32 104 104 33 108 108 35 109 109 39 110 111 39 110 111 37 111 110 33 108 108 35 112 112 34 113 113 38 114 115 38 114 115 39 115 114 35 112 112 34 116 116 32 117 117 36 118 119 36 118 119 38 119 118 34 116 116</p>
        </triangles>
      </mesh>
    </geometry>
    <geometry id="Box03-mesh" name="Box03">
      <mesh>
        <source id="Box03-mesh-positions">
          <float_array id="Box03-mesh-positions-array" count="216">-4.51909 -6 0 -1.50636 -6 0 1.50636 -6 0 4.51909 -6 0 -4.51909 -4.63724 0.000000 -1.77383 -4.63724 0.000000 1.77383 -4.63724 0.000000 4.51909 -4.63724 0.000000 -5.69264 1.08013 -0.000000 -2.23447 1.08013 -0.000000 2.23447 1.08013 -0.000000 5.69264 1.08013 -0.000000 -6 2.4429 0 -2.35512 2.4429 0 2.35512 2.4429 0 6 2.4429 0 -4.51909 -6 1 -1.50636 -6 1 1.50636 -6 1 4.51909 -6 1 -4.51909 -4.63724 1 -1.77383 -4.63724 1 1.77383 -4.63724 1 4.51909 -4.63724 1 -5.69264 1.08013 1 -2.23447 1.08013 1 2.23447 1.08013 1 5.69264 1.08013 1 -6 2.4429 1 -2.35512 2.4429 1 2.35512 2.4429 1 6 2.4429 1 -4.73854 -6.89895 0.955893 4.73854 -6.89895 0.955893 -6 -6.89895 -11.0441 6 -6.89895 -11.0441 -4.73854 -5.89895 0.955893 4.73854 -5.89895 0.955893 -6 -5.89895 -11.0441 6 -5.89895 -11.0441 3.81943 -10.9174 -8.79144 5.19889 -10.9174 -8.79144 3.81943 -10.9174 -10.1709 5.19889 -10.9174 -10.1709 3.81943 -6.9174 -8.79144 5.19889 -6.9174 -8.79144 3.81943 -6.9174 -10.1709 5.19889 -6.9174 -10.1709 3.59564 -10.9174 -0.912474 4.9751 -10.9174 -0.912474 3.59564 -10.9174 -2.29194 4.9751 -10.9174 -2.29194 3.59564 -6.9174 -0.912474 4.9751 -6.9174 -0.912474 3.59564 -6.9174 -2.29194 4.9751 -6.9174 -2.29194 -5.06505 -10.9174 -8.79144 -3.68559 -10.9174 -8.79144 -5.06505 -10.9174 -10.1709 -3.68559 -10.9174 -10.1709 -5.06505 -6.9174 -8.79144 -3.68559 -6.9174 -8.79144 -5.06505 -6.9174 -10.1709 -3.68559 -6.9174 -10.1709 -4.84079 -10.9174 -0.912474 -3.46133 -10.9174 -0.912474 -4.84079 -10.9174 -2.29194 -3.46133 -10.9174 -2.29194 -4.84079 -6.9174 -0.912474 -3.46133 -6.9174 -0.912474 -4.84079 -6.9174 -2.29194 -3.46133 -6.9174 -2.29194</float_array>
          <technique_common>
            <accessor source="#Box03-mesh-positions-array" count="72" stride="3">
              <param name="X" type="float"/>
              <param name="Y" type="float"/>
              <param name="Z" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <source id="Box03-mesh-normals">
          <float_array id="Box03-mesh-normals-array" count="624">0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 1 0 0 0.994881 -0.101051 0 0.994881 -0.101051 0 1 0 0 0.977582 -0.210553 0 0.977582 -0.210553 0 0.975496 -0.220018 0 0.975496 -0.220018 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 -0.975496 -0.220018 0 -0.977582 -0.210553 0 -0.977582 -0.210553 0 -0.975496 -0.220018 0 -0.994881 -0.101051 0 -0.994881 -0.101051 0 -1 0 0 -1 0 0 -0.99677 0.080308 0 -0.99677 0.080308 0 -0.99677 0.080308 0 -0.99677 0.080308 0 -0.99677 0.080308 0 -0.99677 0.080308 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0.99677 0.080308 0 0.99677 0.080308 0 0.99677 0.080308 0 0.99677 0.080308 0 0.99677 0.080308 0 0.99677 0.080308 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 0.99452 0 0.104546 0.99452 0 0.104546 0.99452 0 0.104546 0.99452 0 0.104546 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -0.99452 0 0.104546 -0.99452 0 0.104546 -0.99452 0 0.104546 -0.99452 0 0.104546 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -1 0 0 -1 0 0 -1 0 0 -1 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 0 0 0 0 -1 0 0 -1 0 0 -1 0 0 -1 -1 0 0 -1 0 0 -1 0 0 -1 0 0</float_array>
          <technique_common>
            <accessor source="#Box03-mesh-normals-array" count="208" stride="3">
              <param name="X" type="float"/>
              <param name="Y" type="float"/>
              <param name="Z" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <source id="Box03-mesh-map-channel1">
          <float_array id="Box03-mesh-map-channel1-array" count="552">1 0 0 0.666667 0 0 0.333333 0 0 0 0 0 1 0.333333 0 0.666667 0.333333 0 0.333333 0.333333 0 0 0.333333 0 1 0.666667 0 0.666667 0.666667 0 0.333333 0.666667 0 0 0.666667 0 1 1 0 0.666667 1 0 0.333333 1 0 0 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 0.333333 0 0.333333 0.333333 0 0.666667 0.333333 0 1 0.333333 0 0 0.666667 0 0.333333 0.666667 0 0.666667 0.666667 0 1 0.666667 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 0 0 0 0.333333 0 0 0.666667 0 0 1 0 0 0 1 0 0.333333 1 0 0.666667 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 1 0</float_array>
          <technique_common>
            <accessor source="#Box03-mesh-map-channel1-array" count="184" stride="3">
              <param name="S" type="float"/>
              <param name="T" type="float"/>
              <param name="P" type="float"/>
            </accessor>
          </technique_common>
        </source>
        <vertices id="Box03-mesh-vertices">
          <input semantic="POSITION" source="#Box03-mesh-positions"/>
        </vertices>
        <triangles material="skin_02" count="124">
          <input semantic="VERTEX" source="#Box03-mesh-vertices" offset="0"/>
          <input semantic="NORMAL" source="#Box03-mesh-normals" offset="1"/>
          <input semantic="TEXCOORD" source="#Box03-mesh-map-channel1" offset="2" set="1"/>
          <p>0 0 0 4 1 4 5 2 5 5 2 5 1 3 1 0 0 0 1 3 1 5 2 5 6 4 6 6 4 6 2 5 2 1 3 1 2 5 2 6 4 6 7 6 7 7 6 7 3 7 3 2 5 2 4 1 4 8 8 8 9 9 9 9 9 9 5 2 5 4 1 4 6 4 6 10 10 10 11 11 11 11 11 11 7 6 7 6 4 6 8 8 8 12 12 12 13 13 13 13 13 13 9 9 9 8 8 8 9 9 9 13 13 13 14 14 14 14 14 14 10 10 10 9 9 9 10 10 10 14 14 14 15 15 15 15 15 15 11 11 11 10 10 10 16 16 16 17 17 17 21 18 21 21 18 21 20 19 20 16 16 16 17 17 17 18 20 18 22 21 22 22 21 22 21 18 21 17 17 17 18 20 18 19 22 19 23 23 23 23 23 23 22 21 22 18 20 18 20 19 20 21 18 21 25 24 25 25 24 25 24 25 24 20 19 20 22 21 22 23 23 23 27 26 27 27 26 27 26 27 26 22 21 22 24 25 24 25 24 25 29 28 29 29 28 29 28 29 28 24 25 24 25 24 25 26 27 26 30 30 30 30 30 30 29 28 29 25 24 25 26 27 26 27 26 27 31 31 31 31 31 31 30 30 30 26 27 26 0 32 32 1 33 33 17 34 37 17 34 37 16 35 36 0 32 32 1 33 33 2 36 34 18 37 38 18 37 38 17 34 37 1 33 33 2 36 34 3 38 35 19 39 39 19 39 39 18 37 38 2 36 34 3 40 40 7 41 41 23 42 45 23 42 45 19 43 44 3 40 40 7 41 41 11 44 42 27 45 46 27 45 46 23 42 45 7 41 41 11 44 42 15 46 43 31 47 47 31 47 47 27 45 46 11 44 42 15 48 48 14 49 49 30 50 53 30 50 53 31 51 52 15 48 48 14 49 49 13 52 50 29 53 54 29 53 54 30 50 53 14 49 49 13 52 50 12 54 51 28 55 55 28 55 55 29 53 54 13 52 50 12 56 56 8 57 57 24 58 61 24 58 61 28 59 60 12 56 56 8 57 57 4 60 58 20 61 62 20 61 62 24 58 61 8 57 57 4 60 58 0 62 59 16 63 63 16 63 63 20 61 62 4 60 58 10 64 10 6 65 6 22 66 22 22 67 22 26 68 26 10 69 10 6 70 6 5 71 5 21 72 21 21 73 21 22 74 22 6 75 6 25 76 25 21 77 21 5 78 5 5 79 5 9 80 9 25 81 25 9 82 9 10 83 10 26 84 26 26 85 26 25 86 25 9 87 9 32 88 64 34 89 66 35 90 67 35 90 67 33 91 65 32 88 64 36 92 68 37 93 69 39 94 71 39 94 71 38 95 70 36 92 68 32 96 72 33 97 73 37 98 75 37 98 75 36 99 74 32 96 72 33 100 76 35 101 77 39 102 79 39 102 79 37 103 78 33 100 76 35 104 80 34 105 81 38 106 83 38 106 83 39 107 82 35 104 80 34 108 84 32 109 85 36 110 87 36 110 87 38 111 86 34 108 84 40 112 88 42 113 90 43 114 91 43 114 91 41 115 89 40 112 88 44 116 92 45 117 93 47 118 95 47 118 95 46 119 94 44 116 92 40 120 96 41 121 97 45 122 99 45 122 99 44 123 98 40 120 96 41 124 100 43 125 101 47 126 103 47 126 103 45 127 102 41 124 100 43 128 104 42 129 105 46 130 107 46 130 107 47 131 106 43 128 104 42 132 108 40 133 109 44 134 111 44 134 111 46 135 110 42 132 108 48 136 112 50 137 114 51 138 115 51 138 115 49 139 113 48 136 112 52 140 116 53 141 117 55 142 119 55 142 119 54 143 118 52 140 116 48 144 120 49 145 121 53 146 123 53 146 123 52 147 122 48 144 120 49 148 124 51 149 125 55 150 127 55 150 127 53 151 126 49 148 124 51 152 128 50 153 129 54 154 131 54 154 131 55 155 130 51 152 128 50 156 132 48 157 133 52 158 135 52 158 135 54 159 134 50 156 132 56 160 136 58 161 138 59 162 139 59 162 139 57 163 137 56 160 136 60 164 140 61 165 141 63 166 143 63 166 143 62 167 142 60 164 140 56 168 144 57 169 145 61 170 147 61 170 147 60 171 146 56 168 144 57 172 148 59 173 149 63 174 151 63 174 151 61 175 150 57 172 148 59 176 152 58 177 153 62 178 155 62 178 155 63 179 154 59 176 152 58 180 156 56 181 157 60 182 159 60 182 159 62 183 158 58 180 156 64 184 160 66 185 162 67 186 163 67 186 163 65 187 161 64 184 160 68 188 164 69 189 165 71 190 167 71 190 167 70 191 166 68 188 164 64 192 168 65 193 169 69 194 171 69 194 171 68 195 170 64 192 168 65 196 172 67 197 173 71 198 175 71 198 175 69 199 174 65 196 172 67 200 176 66 201 177 70 202 179 70 202 179 71 203 178 67 200 176 66 204 180 64 205 181 68 206 183 68 206 183 70 207 182 66 204 180</p>
        </triangles>
      </mesh>
    </geometry>
  </library_geometries>
  <library_visual_scenes>
    <visual_scene id="desktop.max" name="desktop_max">
      <node id="Box01-node" name="Box01" type="NODE">
        <translate>1.3224 1.57203 9.65622</translate>
        <instance_geometry url="#Box01-mesh">
          <bind_material>
            <technique_common>
              <instance_material symbol="skin_01" target="#skin_01"/>
            </technique_common>
          </bind_material>
        </instance_geometry>
      </node>
      <node id="Box03-node" name="Box03" type="NODE">
        <translate>24.8844 -4.13575 10.9773</translate>
        <rotate>-1 0 0 -90</rotate>
        <instance_geometry url="#Box03-mesh">
          <bind_material>
            <technique_common>
              <instance_material symbol="skin_02" target="#skin_02"/>
            </technique_common>
          </bind_material>
        </instance_geometry>
      </node>
      <extra>
        <technique profile="FCOLLADA">
          <start_time>0</start_time>
          <end_time>3.33333</end_time>
        </technique>
      </extra>
      <extra>
        <technique profile="MAX3D">
          <frame_rate>30</frame_rate>
        </technique>
      </extra>
    </visual_scene>
  </library_visual_scenes>
  <scene>
    <instance_visual_scene url="#desktop.max"/>
  </scene>
</COLLADA>;
		
	}

}