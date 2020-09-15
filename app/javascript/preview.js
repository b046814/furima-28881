  window.addEventListener('load', function(){
    const ImagePreview = document.getElementById("image-preview")
    const ImageInput = document.getElementById("item-image")
    
    ImageInput.addEventListener('change', function(e) {
      
      const imageContent = document.getElementById('image-file')
      if (imageContent){
        imageContent.remove();
      }
      
      const file = e.target.files[0]
      const ImageUrl = window.URL.createObjectURL(file)
    
      const ImageParent = document.createElement('div')
      const ImageChild = document.createElement('img')
    
      ImageChild.setAttribute('src', ImageUrl)
      ImageChild.setAttribute('class', 'preview')
      ImageChild.setAttribute('id', 'image-file')
    
      ImageParent.appendChild(ImageChild)
      ImagePreview.appendChild(ImageParent)

  })
})
