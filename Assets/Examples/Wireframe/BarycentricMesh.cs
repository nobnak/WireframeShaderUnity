using UnityEngine;
using System.Collections;

[RequireComponent(typeof(MeshFilter))]
public class BarycentricMesh : MonoBehaviour {

	Mesh mesh;

    #region unity
    void OnEnable () {
		var mf = GetComponent<MeshFilter>();
		mesh = mf.mesh;

		var triangles0 = mesh.triangles;
		var vertices0 = mesh.vertices;
		var normals0 = mesh.normals;
		var tangents0 = mesh.tangents;
		var uv0 = mesh.uv;

		var triangles1 = new int[triangles0.Length];
		var vertices1 = new Vector3[triangles0.Length];
		var normals1 = new Vector3[vertices1.Length];
		var tangents1 = new Vector4[vertices1.Length];
		var uv1 = new Vector2[vertices1.Length];

		var bary = new Vector4[vertices1.Length];

		for (var i = 0; i < triangles0.Length; i++) {
			var index = triangles0[i];
			vertices1[i] = vertices0[index];
			uv1[i] = uv0[index];
			triangles1[i] = i;
		}
		mesh.vertices = vertices1;
		mesh.triangles = triangles1;
		mesh.uv = uv1;

		var counter = 0;
		for (var i = 0; i < triangles0.Length; i+=3) {
			bary[counter++] = new Vector4(1, 0, 0, 0);
			bary[counter++] = new Vector4(0, 1, 0, 0);
			bary[counter++] = new Vector4(0, 0, 1, 0);
		}
		mesh.tangents = bary;

		if (normals0 != null && normals0.Length > 0) {
			for (var i = 0; i < triangles0.Length; i++)
				normals1[i] = normals0[triangles0[i]];
			mesh.normals = normals1;
		}
	}
    void OnDisable() {
        if (mesh != null) {
			Object.Destroy(mesh);
		}
    }
    #endregion
}
